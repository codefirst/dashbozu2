class User < ActiveRecord::Base
  devise :omniauthable

  belongs_to :parent_user, class_name: 'User'
  has_many :users

  def self.update_or_create_user_with_oauth(oauth, current_user)
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
    parent_user = self.get_or_create_parent_user(user, current_user)
    user.parent_user = parent_user
    user.save

    parent_user
  end

  private
  def self.get_or_create_parent_user(oauth_user, current_user)
    parent_user = if current_user
      current_user
    elsif oauth_user.parent_user
      oauth_user.parent_user
    else
       User.new(name: oauth_user.name, nickname: oauth_user.nickname, image: oauth_user.image)
    end

    parent_user.users.delete_if {|user| user.provider == oauth_user.provider}
    parent_user.users << oauth_user
    parent_user.save
    parent_user
  end

end
