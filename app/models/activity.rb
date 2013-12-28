class Activity < ActiveRecord::Base
  belongs_to :project

  before_save :generate_identifier

  def self.joined_projects(user)
    user_projects = UserProject.joins(:project).where('user_projects.user_id' => user.id)
    project_ids = user_projects.pluck(:project_id)
    Activity.where(project_id: project_ids).includes(:project)
  end

  private
  def generate_identifier
    if self.project
      identifier = self.project.api_key + '-' + self.id.to_s
      self.encrypted_identifier = Digest::SHA1.hexdigest(identifier)
    end
  end
end
