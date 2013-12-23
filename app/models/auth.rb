class Auth < ActiveRecord::Base
  belongs_to :user

  def self.get_or_create_by_authhash(authhash)
    "#{authhash.provider}_auth".classify.constantize.get_or_create_by_authhash(authhash)
  end
end
