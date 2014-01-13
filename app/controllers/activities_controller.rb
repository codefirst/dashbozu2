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
    else
      render text: 'Project not found', status: 404
    end
  end

  def all
    @activities = Activity.joined_projects(current_user).page(params[:page]).per(PER_PAGE).order('created_at desc')
    render template: 'activities/index'
  end

  def show
    @activity = Activity.where(encrypted_identifier: params[:id]).first
    render text: 'Activity not found', status: 404 unless @activity
  end

  def embed
    @activity = Activity.where(encrypted_identifier: params[:id]).first
    if @activity
      render layout: false, template: 'activities/show'
    else
      render text: 'Activity not found', status: 404
    end
  end

end
