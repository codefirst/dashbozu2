class BitbucketServiceClient
  def initialize(provider, oauth_credentials)
    @provider, @oauth_credentials = provider, oauth_credentials
  end

  def organizations
    []
  end

  def projects(owner, per_page = nil, page = nil)
    bitbucket = BitBucket.new(oauth_token: @oauth_credentials[:token],
                              oauth_secret:  @oauth_credentials[:secret],
                              client_id: Settings.omniauth.bitbucket.key,
                              client_secret: Settings.omniauth.bitbucket.secret)
    bitbucket.repos.list.map do |repo|
      Project.new(provider: @provider, name: "#{repo.owner}/#{repo.name}")
    end
  end
end
