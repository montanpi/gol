class GameController < ApplicationController
  def index; end

  def update_matrix
    current_user.matrix = game_of_life(current_user.matrix)
    current_user.save
    update_matrix_text
  end

  private

  def update_matrix_text
    render turbo_stream:
      turbo_stream.replace(
        'matrix',
        partial: 'game/matrix',
        locals: { matrix: current_user.matrix }
      )
  end

  def game_of_life(input)
    matrix = input.split("\n").map { |row| row.chars }
    rows = matrix.length
    cols = matrix.first.length
    output = Array.new(rows) { Array.new(cols) }
    (0...rows).each do |row|
      (0...cols).each do |col|
        cell = matrix[row][col]
        live_neighbors = count_live_neighbors(matrix, row, col)
        output[row][col] = if cell == '*' && [2, 3].include?(live_neighbors)
                             '*'
                           elsif cell == '.' && live_neighbors == 3
                             '*'
                           else
                             '.'
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
      next unless neighbor_row >= 0 && neighbor_row < rows && neighbor_col >= 0 && neighbor_col < cols

      live_count += 1 if matrix[neighbor_row][neighbor_col] == '*'
    end
    live_count
  end
end
