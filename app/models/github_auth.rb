class GithubAuth  < Auth
  def self.get_or_create_by_authhash(authhash)
    condition = {provider: authhash.provider, uid: authhash.uid}
    auth = self.where(condition).first || self.new(condition)
    auth.email = authhash.info.email
    auth.image = authhash.info.image
    auth.name = authhash.info.name
    auth.nickname = authhash.info.nickname
    auth.save!
    auth
  end
end
