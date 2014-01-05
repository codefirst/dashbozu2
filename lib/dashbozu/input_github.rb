module Dashbozu
  class InputGitHub < Input
    Dashbozu::Plugin.register_input('github', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:payload]
      json = MultiJson.load(payload_body)
      if json['before']
        return hook_push(project, json)
      elsif json['issue']
        return hook_issue(project, json)
      end
    end

    private
    def hook_push(project, json)
      repos_name = json['repository']['name']
      json['commits'].map do |c|
        Activity.new(
          project_id: project.id,
          title: "#{repos_name} / #{c['id'][0..8]}",
          body: c['message'],
          url: c['url'],
          author: c['author']['username'],
          icon_url: GravatarImageTag.gravatar_url(c['author']['email']),
          source: 'github'
        )
      end
    end

    def hook_issue(project, json)
      issue = json['issue']
      user = issue['user']
      [Activity.new(
        project_id: project.id,
        title: issue['title'],
        body: issue['body'],
        url: issue['html_url'],
        author: user['login'],
        icon_url: user['avatar_url'],
        source: 'github'
      )]
    end
  end
end
