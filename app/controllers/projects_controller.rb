class ProjectsController < ApplicationController
  SHOW_PROJECTS_PER_PAGE = 20

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.without_provided_by_dashbozu
    if @projects.empty?
      redirect_to action: :from_service, provider: logged_provider
      return
    end
  end

  def from_service
    provider = params[:provider]
    auth = current_user.auth_of(provider)
    nickname = auth.nickname
    params[:owner] ||= nickname
    owner = params[:owner]
    oauth_credentials = credentials_by(provider)
    unless oauth_credentials
      redirect_to user_omniauth_authorize_path(provider: provider, connect: true)
      return
    end
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

  def hooks
    @project = Project.with_api_key(params[:api_key]).first
    @plugins = Dashbozu::Plugin.project_input
  end

end
