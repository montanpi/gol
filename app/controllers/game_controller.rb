class GameController < ApplicationController
  def index; end

  # def update_matrix
  #   current_user.matrix = game_of_life(current_user.matrix)
  #   current_user.save
  #   update_matrix_text
  # end

  # private

  # def update_matrix_text
  #   render turbo_stream:
  #     turbo_stream.replace(
  #       'matrix',
  #       partial: 'game/matrix',
  #       locals: { matrix: current_user.matrix }
  #     )
  # end
end
