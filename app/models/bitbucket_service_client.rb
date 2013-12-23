class BitbucketServiceClient
  def initialize(provider, oauth_credentials)
    @provider, @oauth_credentials = provider, oauth_credentials
  end

  def organizations
    []
  end

  def repositories(owner)
    bitbucket = BitBucket.new(oauth_token: @oauth[:token], oauth_secret:  @oauth[:secret], client_id: Settings.omniauth.bitbucket.key, client_secret: Settings.omniauth.bitbucket.secret)
    public_repos = bitbucket.repos.list.select {|repo| not repo.is_private}
    public_repos.map do |repo|
      provider = @user.provider
      owner = repo.owner
      name = repo.name
      Repository.new(provider: provider, owner: owner, name: name, user: @user)
    end
  end

  def register_hook(owner_name, repository_name, url)
    bitbucket = BitBucket.new(oauth_token: @oauth[:token], oauth_secret:  @oauth[:secret], client_id: Settings.omniauth.bitbucket.key, client_secret: Settings.omniauth.bitbucket.secret)
    params = {"type" => "POST", "URL" => url}
    bitbucket.repos.services.create(owner_name, repository_name, params)
  end

  def remove_hook(owner_name, repository_name, url)
    bitbucket = BitBucket.new(oauth_token: @oauth[:token], oauth_secret:  @oauth[:secret], client_id: Settings.omniauth.bitbucket.key, client_secret: Settings.omniauth.bitbucket.secret)
    regexp = Regexp.new("^#{url.split('/')[0..-1].join('/')}")

    bitbucket.repos.services.list(owner_name, repository_name).each do |service_hash|
      if is_post_service_of(service_hash, regexp)
        bitbucket.repos.services.delete(owner_name, repository_name, service_hash.id)
      end
    end
  end

  private
  def is_post_service_of(service_hash, regexp)
    service_hash.service.type == "POST" and regexp =~ url_field_value(service_hash)
  end

  def url_field_value(service_hash)
    url_field = service_hash.service.fields.find {|field| field.name == "URL"}
    return nil if  url_field.nil?
    url_field.value
  end
end
