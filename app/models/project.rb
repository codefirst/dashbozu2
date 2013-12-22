class Project < ActiveRecord::Base
  has_many :activities

  before_create :generate_api_key

  has_many :user_projects
  has_many :users, through: :user_projects

  private
  def generate_api_key
    self.api_key = SecureRandom.uuid.split('-').join
  end
end
