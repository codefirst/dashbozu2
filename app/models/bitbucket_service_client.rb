class BitbucketServiceClient
  def initialize(provider, oauth_credentials)
    @provider, @oauth_credentials = provider, oauth_credentials
  end

  def organizations
    []
  end

  def projects(owner)
    bitbucket = BitBucket.new(oauth_token: @oauth_credentials[:token],
                              oauth_secret:  @oauth_credentials[:secret],
                              client_id: Settings.omniauth.bitbucket.key,
                              client_secret: Settings.omniauth.bitbucket.secret)
    public_repos = bitbucket.repos.list.select {|repo| not repo.is_private}
    public_repos.map do |repo|
      Project.new(provider: @provider, name: "#{repo.owner}/#{repo.name}")
    end
  end
end
