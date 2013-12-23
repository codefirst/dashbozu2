class User < ActiveRecord::Base
  devise :omniauthable

  has_many :auths
  has_many :user_projects
  has_many :projects, through: :user_projects

  def self.update_or_create_user_with_oauth(oauth)
    nickname = oauth.info.nickname || oauth.uid
    user = User.where(uid: oauth.uid, provider: oauth.provider).first
    if user
      user.name = oauth.info.name
      user.nickname = nickname
    else
      user = User.new(name: oauth.info.name, nickname: nickname, provider: oauth.provider)
    end
    user.uid = oauth.uid
    user.image = oauth.info.image || oauth.info.avatar
    dashbozu_user = DashbozuUser.get_or_create_dashbozu_user(user)
    user.dashbozu_user = dashbozu_user
    user.save

    dashbozu_user
  end

  def service_user(provider)
    self.service_users.where(provider: provider).first
  end

  def organizations(provider, oauth)
    user = service_user(provider)
    return [] unless user
    service_client = ServiceClientFactory.new_instance(user, oauth)
    return [] unless service_client
    service_client.organizations
  end

  def projects_from_service(provider, oauth, owner)
    user = service_user(provider)
    return [] unless user
    service_client = ServiceClientFactory.new_instance(user, oauth)
    return [] unless service_client
    service_client.projects(owner)
  end
end
