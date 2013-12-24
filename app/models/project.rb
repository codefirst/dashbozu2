class Project < ActiveRecord::Base
  has_many :activities

  before_create :generate_api_key

  has_many :user_projects
  has_many :users, through: :user_projects

  scope :with_api_key, lambda {|api_key| where(api_key: api_key) }

  def create_association(user)
    condition = {project_id: self.id, user_id: user.id}
    return unless UserProject.where(condition).empty?
    UserProject.create!(condition)
  end

  def delete_association(user)
    condition = {project_id: self.id, user_id: user.id}
    UserProject.delete_all(condition)
  end

  private
  def generate_api_key
    self.api_key = SecureRandom.uuid.split('-').join
  end
end
