class ActivitiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :embed]
  skip_before_filter :verify_authenticity_token, only: [:show, :embed]

  PER_PAGE = 10
  before_action :set_activity, only: [:edit, :update, :destroy]

  # GET /activities
  # GET /activities.json
  def index
    project = Project.with_api_key(params[:api_key]).first
    if project
      @activities = project.activities.page(params[:page]).per(PER_PAGE).order('created_at desc')
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


  # GET /activities/new
  def new
    @activity = Activity.new
  end

  # GET /activities/1/edit
  def edit
  end

  # POST /activities
  # POST /activities.json
  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
      if @activity.save
        format.html { redirect_to @activity, notice: 'Activity was successfully created.' }
        format.json { render action: 'show', status: :created, location: @activity }
      else
        format.html { render action: 'new' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /activities/1
  # PATCH/PUT /activities/1.json
  def update
    respond_to do |format|
      if @activity.update(activity_params)
        format.html { redirect_to @activity, notice: 'Activity was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /activities/1
  # DELETE /activities/1.json
  def destroy
    @activity.destroy
    respond_to do |format|
      format.html { redirect_to activities_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def activity_params
      params.require(:activity).permit(:title, :body, :source, :project_id, :url, :icon_url, :status, :author)
    end
end
