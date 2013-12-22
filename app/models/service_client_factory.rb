class ServiceClientFactory
  def self.new_instance(user, oauth)
    case user.provider
    when 'github'
      return GithubServiceClient.new(user, oauth)
    when 'bitbucket'
      return BitbucketServiceClient.new(user, oauth)
    end
    nil
  end
end
