class User < ActiveRecord::Base
  devise :omniauthable

  has_many :auths
  has_many :user_projects
  has_many :projects, through: :user_projects

  def connect_with(auth)
    if auth.user and auth.user_id != self.id
      auth.user = self
      auth.save!
    else
      self.auths << auth
    end
    self.name = auth.name
    self.email = auth.email
    save!
  end

  def auth_of(provider)
    self.auths.where(provider: provider).first
  end

  def organizations(provider, oauth_credentials)
    auth = auth_of(provider)
    return [] unless auth
    service_client = ServiceClientFactory.new_instance(provider, oauth_credentials)
    return [] unless service_client
    service_client.organizations
  end

  def projects_from_service(provider, oauth_credentials, owner)
    auth = auth_of(provider)
    return [] unless auth
    service_client = ServiceClientFactory.new_instance(provider, oauth_credentials)
    return [] unless service_client
    service_client.projects(owner)
  end
end
