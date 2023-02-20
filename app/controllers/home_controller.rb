class HomeController < ApplicationController
  def index; end

  def upload
    uploaded_file = params[:file]
    str = uploaded_file.read
    if validate_string(str)
      matrix = str.split("\n")[2..-1]
      current_user.matrix = matrix.join("\n")
      current_user.save
      redirect_to game_path
    else
      # TODO: display some alert for invalid file
    end
  end

  private

  def validate_string(str)
    lines = str.split("\n")
    return false unless lines[0] =~ /^Generation \d:$/
    return false unless lines[1] =~ /^(\d) (\d)$/

    rows = ::Regexp.last_match(1).to_i
    cols = ::Regexp.last_match(2).to_i
    return false unless lines.length == rows + 2
    return false unless lines[2..-1].all? { |line| line.length == cols && line =~ /^[*.]*$/ }

    true
  end
end
