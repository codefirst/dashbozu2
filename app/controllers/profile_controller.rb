class ProfileController < ApplicationController
  def show
    @user_project = current_user.projects.provided_by_dashbozu.first
  end

  def hooks
    @project = current_user.projects.provided_by_dashbozu.first
    @plugins = Dashbozu::Plugin.user_input
  end
end
