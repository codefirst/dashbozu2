class ServiceClientFactory
  def self.new_instance(provider, oauth_credentials)
    case provider
    when 'github'
      return GithubServiceClient.new(provider, oauth_credentials)
    when 'bitbucket'
      return BitbucketServiceClient.new(provider, oauth_credentials)
    end
    nil
  end
end
