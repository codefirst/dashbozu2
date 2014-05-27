class Auth < ActiveRecord::Base
  belongs_to :user

  def self.name_of(provider)
    "#{provider}_auth".classify.constantize.provider_name
  end

  def self.find_or_create_by_authhash(authhash)
    "#{authhash.provider}_auth".classify.constantize.find_or_create_by_authhash(authhash)
  end
end
