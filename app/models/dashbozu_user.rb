class DashbozuUser < User
  has_many :users

  def self.get_or_create_dashbozu_user(user)
    return nil if user.nil?
    return user.dashbozu_user if user.dashbozu_user
    dashbozu_user = DashbozuUser.new(name: user.name)
    dashbozu_user.users << user
    return nil unless dashbozu_user.save
    dashbozu_user
  end
end
