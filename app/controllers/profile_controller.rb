class ProfileController < ApplicationController
  def show
    @user_project = current_user.projects.provided_by_dashbozu.first
  end
end
