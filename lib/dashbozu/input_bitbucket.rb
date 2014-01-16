module Dashbozu
  class InputBitbucket < Input
    Dashbozu::Plugin.register_input('bitbucket', self)

    def initialize
      super
    end

    def hook(project, params)
      if params[:payload]
        json = MultiJson.load(params[:payload])
        return hook_push(project, json)
      end
      ['created', 'merged', 'declined', 'updated'].each do |action|
        if params["pullrequest_#{action}"]
          return hook_pullrequest(project, params, action)
        end
      end
      ['created', 'deleted', 'updated'].each do |action|
        if params["pullrequest_comment_#{action}"]
          return hook_pullrequest_comment(project, params, action)
        end
      end
      []
    end

    private
    def hook_push(project, json)
      repos_name = json['repository']['name']
      url = "#{json['canon_url']}#{json['repository']['absolute_url']}"
      json['commits'].map do |c|
        Activity.new(
          project_id: project.id,
          title: "[Commit] #{repos_name} - #{c['node'][0..8]}",
          body: c['message'],
          url: "#{url}commits/#{c['raw_node']}",
          author: c['author'],
          icon_url: GravatarImageTag.gravatar_url(extract_email(c['raw_author'])),
          source: 'bitbucket'
        )
      end
    end

    def hook_pullrequest(project, json, action)
      pullreq = json["pullrequest_#{action}"]
      repo_full_name = pullreq['destination']['repository']['full_name']
      url = "https://bitbucket.org/#{repo_full_name}"
      url << "/pull-request/#{pullreq['id']}" if pullreq['id']
      [Activity.new(
        project_id: project.id,
        title: "[Pull Request] #{repo_full_name} - ##{pullreq['id']} #{action}: #{pullreq['title']}",
        body: pullreq['description'],
        url: url,
        author: pullreq['author']['username'],
        icon_url: pullreq['author']['links']['avatar']['href'],
        source: 'bitbucket'
      )]
    end

    def hook_pullrequest_comment(project, json, action)
      pullreq = json["pullrequest_comment_#{action}"]
      url = pullreq['links']['html']['href']
      repo_full_name = extract_full_repo_name(url)
      pullrequest_id = extract_pullrequest_id(url)
      [Activity.new(
        project_id: project.id,
        title: "[Pull Request Comment] #{repo_full_name} - ##{pullrequest_id} #{action}",
        body: pullreq['content']['raw'],
        url: "https://bitbucket.org/#{repo_full_name}/pull-request/#{pullrequest_id}",
        author: pullreq['user']['username'],
        icon_url: pullreq['user']['links']['avatar']['href'],
        source: 'bitbucket'
      )]
    end

    def extract_email(raw_author)
      return '' if raw_author.blank?
      extracted = raw_author.scan(/.*<(.*)>/)
      return '' if extracted.empty?
      last = extracted.last
      return '' if last.empty?
      last.last
    end

    def extract_full_repo_name(comment_url)
      return '' if comment_url.blank?
      extracted = comment_url.scan(/bitbucket\.org\/(.*)\/(.*)\/pull-request/)
      return '' if extracted.empty?
      last = extracted.last
      return '' if last.empty?
      last.join('/')
    end

    def extract_pullrequest_id(comment_url)
      return '' if comment_url.blank?
      extracted = comment_url.scan(/bitbucket\.org\/.*\/.*\/pull-request\/(\d*)/)
      return '' if extracted.empty?
      last = extracted.last
      return '' if last.empty?
      last.last
    end
  end
end
