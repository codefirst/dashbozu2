class TopController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if user_signed_in?
      redirect_to projects_path
    end
  end
end
