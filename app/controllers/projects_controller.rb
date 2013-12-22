class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.service_users.reduce ([]) do |projs, user|
      projs += user.projects
    end
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
    service_user = current_user.service_user(provider)
    nickname = service_user.nickname
    params[:owner] ||= nickname
    owner = params[:owner]
    oauth = session["#{provider}_oauth"]
    @owners = [nickname] + current_user.organizations(provider, oauth)
    @projects = current_user.projects_from_service(provider, oauth, owner) || []
    @associated_projects = service_user.projects
  end

  def toggle
    provider = params[:provider]
    service_user = current_user.service_user(provider)
    condition = {provider: provider, name: params[:name]}
    project = Project.where(condition).first
    project ||= Project.new(condition)
    project.users << service_user unless project.users.exists?(service_user)

#    repository.enabled = !repository.enabled
#    if repository.enabled
#      register_hook(params[:provider], params[:owner], params[:name])
#    else
#      remove_hook(params[:provider], params[:owner], params[:name])
#    end
    project.save
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
