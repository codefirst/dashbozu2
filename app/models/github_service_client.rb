class GithubServiceClient
  def initialize(user, oauth)
    @user = user
    @oauth = oauth
  end

  def organizations
    Octokit::Client.new(access_token: @oauth[:token]).organizations.map do |organization|
      organization.login
    end
  end

  def projects(owner)
    Octokit::Client.new(access_token: @oauth[:token]).repos(owner).map do |repo|
      provider = @user.provider
      name = "#{repo.owner.login}/#{repo.name}"
      Project.new(provider: provider, name: name)
    end
  end

  def register_hook(owner_name, repository_name, url)
    config = {url: url, content_type: "json"}
    options = {events: ['push'], active: true}
    client = Octokit::Client.new(access_token: @oauth[:token])
    client.create_hook({owner: owner_name, name: repository_name}, 'web', config, options)
  end

  def remove_hook(owner_name, repository_name, url)
    client = Octokit::Client.new(access_token: @oauth[:token])
    regexp = Regexp.new("^#{url.split('/')[0..-1].join('/')}")
    repository = {owner: owner_name, name: repository_name}
    client.hooks(repository).each do |hook|
      if hook.name == 'web' and regexp =~ hook.config.rels[:self].href
        client.remove_hook(repository, hook.id)
      end
    end
  end
end
