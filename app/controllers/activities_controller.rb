class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :embed]
  skip_before_filter :verify_authenticity_token, only: [:show, :embed]

  PER_PAGE = 10

  # GET /activities
  # GET /activities.json
  def index
    @project = Project.with_api_key(params[:api_key]).first
    if @project
      @activities = @project.activities.page(params[:page]).per(PER_PAGE).order('created_at desc')
      flash.now[:notice] = "Set WebHooks to external services. See #{ActionController::Base.helpers.link_to 'all hook list', project_hooks_path(@project.api_key)}." if @activities.empty?
    else
      render text: 'Project not found', status: 404
    end
  end

  def user
    @project = current_user.projects.provided_by_dashbozu.first
    if @project
      @activities = @project.activities.page(params[:page]).per(PER_PAGE).order('created_at desc')
      flash.now[:notice] = "Set WebHooks to external services. See #{ActionController::Base.helpers.link_to 'all hook list', profile_hooks_path}." if @activities.empty?
    else
      render text: 'Project not found', status: 404
    end
  end

  def all
    @activities = Activity.joined_projects(current_user).page(params[:page]).per(PER_PAGE).order('created_at desc')
    render template: 'activities/index'
  end

  def show
    @activity = Activity.find(params[:id])
    render text: 'Activity not found', status: 404 unless @activity
  end

  def embed
    @activity = Activity.find(params[:id])
    if @activity
      render layout: false
    else
      render text: 'Activity not found', status: 404
    end
  end

end
