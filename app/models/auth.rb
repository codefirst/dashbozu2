class Auth < ActiveRecord::Base
  belongs_to :user

  def self.get_or_create_by_oauth(oauth)
    condition = {provider: oauth.provider, uid: oauth.uid}
    auth = Auth.where(condition).first || Auth.new(condition)
    auth.email = oauth.info.email
    auth.image = oauth.info.image
    auth.name = oauth.info.name
    auth.nickname = oauth.info.nickname
    auth.save!
    auth
  end
end
