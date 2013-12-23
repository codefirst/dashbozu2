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
      Project.new(provider: 'github', name: name)
    end
  end

  def register_hook(owner_name, repository_name, url)
    config = {url: url, content_type: "json"}
    options = {events: ['push'], active: true}
    client = Octokit::Client.new(access_token: @oauth_credentials[:token])
    client.create_hook({owner: owner_name, name: repository_name}, 'web', config, options)
  end

  def remove_hook(owner_name, repository_name, url)
    client = Octokit::Client.new(access_token: @oauth_credentials[:token])
    regexp = Regexp.new("^#{url.split('/')[0..-1].join('/')}")
    repository = {owner: owner_name, name: repository_name}
    client.hooks(repository).each do |hook|
      if hook.name == 'web' and regexp =~ hook.config.rels[:self].href
        client.remove_hook(repository, hook.id)
      end
    end
  end
end
