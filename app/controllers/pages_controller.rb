class PagesController < ApplicationController
  before_action :authenticate_user!

  def home
  end

  def update_counter
    current_user.matrix += 'x'
    current_user.save

    # redirect_to root_path
    update_counter_text
  end

  private
  def update_counter_text
    render turbo_stream:
      turbo_stream.replace(
        "counter",
        partial: "pages/counter",
        locals: { counter: current_user.matrix }
      )
  end
end
