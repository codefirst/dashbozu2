class GithubServiceClient
  def initialize(provider, oauth_credentials)
    @provider, @oauth_credentials = provider, oauth_credentials
  end

  def organizations
    Octokit::Client.new(access_token: @oauth_credentials[:token]).organizations.map do |organization|
      organization.login
    end
  end

  def projects(owner)
    Octokit::Client.new(access_token: @oauth_credentials[:token]).repos(owner).map do |repo|
      name = "#{repo.owner.login}/#{repo.name}"
      Project.new(provider: @provider, name: name)
    end
  end
end
