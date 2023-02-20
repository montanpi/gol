class SseController < ApplicationController
  include ActionController::Live

  def start
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate
    sse = SSE.new(response.stream, retry: 300, event: 'open')
    matrix = current_user.matrix
    loop do
      matrix = game_of_life(matrix)
      matrix_html = build_html(matrix)
      sse.write({ matrix: matrix_html }, event: 'update-event')
      sleep 0.5
    end
  rescue ActionController::Live::ClientDisconnected
    current_user.matrix = matrix
    current_user.save
    sse.close
  ensure
    sse.close
  end

  def stop; end

  def build_html(str)
    rows = str.split("\n")
    table_html = '<table>'
    rows.each do |row|
      table_html += '<tr>'
      row.chars.each do |char|
        table_html += "<td>#{char == '*' ? '◾️' : '◽️'}</td>"
      end
      table_html += '</tr>'
    end
    table_html += '</table>'
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
