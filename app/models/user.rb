class User < ActiveRecord::Base
  devise :omniauthable

  belongs_to :dashbozu_user
  has_many :service_users, class_name: 'User', foreign_key: 'dashbozu_user_id'

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
end
