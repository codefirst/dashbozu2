class GithubServiceClient
  def initialize(provider, oauth_credentials)
    @provider, @oauth_credentials = provider, oauth_credentials
  end

  def organizations
    Octokit::Client.new(access_token: @oauth_credentials[:token]).organizations.map do |organization|
      organization.login
    end
  end

  def projects(owner, per_page = 20, page = 1)
    Octokit::Client.new(access_token: @oauth_credentials[:token]).repos(owner, per_page: per_page, page: page).map do |repo|
      name = "#{repo.owner.login}/#{repo.name}"
      Project.new(provider: @provider, name: name)
    end
  end

  def project_count(owner)
    count = Octokit::Client.new(access_token: @oauth_credentials[:token]).user(owner).public_repos
    Rails.logger.info count
    count
  end
end
