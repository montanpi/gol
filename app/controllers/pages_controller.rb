class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def update_matrix
    current_user.matrix = game_of_life(current_user.matrix)
    current_user.save
    update_matrix_text
  end

  private
  def update_matrix_text
    render turbo_stream:
      turbo_stream.replace(
        "matrix",
        partial: "pages/matrix",
        locals: { matrix: current_user.matrix }
      )
  end

  private
  def game_of_life(input)
    matrix = input.split("\n").map { |row| row.chars }
    rows = matrix.length
    cols = matrix.first.length
    output = Array.new(rows) { Array.new(cols) }
    (0...rows).each do |row|
      (0...cols).each do |col|
        cell = matrix[row][col]
        live_neighbors = count_live_neighbors(matrix, row, col)
        if cell == "*" && (live_neighbors == 2 || live_neighbors == 3)
          output[row][col] = "*"
        elsif cell == "." && live_neighbors == 3
          output[row][col] = "*"
        else
          output[row][col] = "."
        end
      end
    end
    output.map { |row| row.join }.join("\n")
  end

  def count_live_neighbors(matrix, row, col)
    rows = matrix.length
    cols = matrix.first.length
    offsets = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1], [0, 1],
      [1, -1], [1, 0], [1, 1]
    ]
    live_count = 0
    offsets.each do |offset|
      neighbor_row = row + offset[0]
      neighbor_col = col + offset[1]
      if neighbor_row >= 0 && neighbor_row < rows && neighbor_col >= 0 && neighbor_col < cols
        if matrix[neighbor_row][neighbor_col] == "*"
          live_count += 1
        end
      end
    end
    return live_count
  end
end
