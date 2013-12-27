class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  SHOW_PROJECTS_PER_PAGE = 20

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  def from_service
    provider = params[:provider]
    auth = current_user.auth_of(provider)
    nickname = auth.nickname
    params[:owner] ||= nickname
    owner = params[:owner]
    oauth_credentials = credentials_by(provider)
    @per_page = SHOW_PROJECTS_PER_PAGE
    @page = (params[:page] || '1').to_i
    @owners = [nickname] + current_user.organizations(provider, oauth_credentials)
    @projects = current_user.projects_from_service(provider, oauth_credentials, owner, @per_page, @page) || []
    @project_count = current_user.project_count(provider, oauth_credentials, owner) || 0
    @registered_projects = current_user.projects
  end

  def toggle
    provider = params[:provider]

    condition = {provider: provider, name: params[:name]}
    project = Project.where(condition).first || Project.new(condition)
    project.save

    if (not params[:state].blank?) and (params[:state].downcase == 'true')
      project.create_association(current_user)
    else
      project.delete_association(current_user)
    end

    redirect_to projects_from_service_path(provider)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name)
    end
end
