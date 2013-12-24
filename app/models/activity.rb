class Activity < ActiveRecord::Base
  belongs_to :project

  def self.joined_projects(user)
    user_projects = UserProject.joins(:project).where('user_projects.user_id' => user.id)
    project_ids = user_projects.pluck(:project_id)
    Activity.where(project_id: project_ids).includes(:project)
  end
end
