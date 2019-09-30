module Dashbozu
  class InputGitHub < Input
    Dashbozu::Plugin.register_input('github', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:payload]
      if payload_body.blank?
        json = params
      else
        json = MultiJson.load(payload_body)
      end

      if json['before']
        return hook_push(project, json)
      elsif json['issue']
        if json['comment']
          return hook_comment(project, json)
        else
          return hook_issue(project, json)
        end
      elsif json['pull_request']
        return hook_pull_request(project, json)
      elsif json['check_run']
        return hook_check_run(project, json)
      end
      return []
    end

    private
    def hook_push(project, json)
      repos_name = json['repository']['name']
      return [] unless json['commits']
      json['commits'].map do |c|
        Activity.new(
          project_id: project.id,
          title: "[Commit] #{repos_name} - #{c['id'][0..8]}",
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
        title: "[Issue] #{issue['html_url'].split('/')[4]} - ##{issue['number']} #{json['action']}: #{issue['title']}",
        body: issue['body'],
        url: issue['html_url'],
        author: user['login'],
        icon_url: user['avatar_url'],
        source: 'github'
      )]
    end

    def hook_pull_request(project, json)
      pull_request = json['pull_request']
      user = pull_request['user']
      [Activity.new(
        project_id: project.id,
        title: "[Pull Request] #{pull_request['head']['repo']['name']} - ##{pull_request['number']} #{json['action']}: #{pull_request['title']}",
        body: pull_request['body'],
        url: pull_request['html_url'],
        author: user['login'],
        icon_url: user['avatar_url'],
        source: 'github'
      )]
    end

    def hook_check_run(project, json)
      return [] unless json['action'] == 'completed'

      check_run = json['check_run']
      user = json['sender']
      [Activity.new(
        project_id: project.id,
        title: "#{json['repository']['name']} -  #{check_run['conclusion']}",
        body: check_run['body'],
        status: check_run['conclusion'] == 'success' ? 'success' : 'error',
        url: check_run['check_suite']['head_branch'],
        author: user['login'],
        icon_url: user['avatar_url'],
        source: 'github'
      )]
    end

    def hook_comment(project, json)
      comment = json['comment']
      issue = json['issue']
      user = comment['user']
      [Activity.new(
        project_id: project.id,
        title: "[Comment] #{json['repository']['name']} - ##{issue['number']} #{json['action']}: #{issue['title']}",
        body: comment['body'],
        url: comment['html_url'],
        author: user['login'],
        icon_url: user['avatar_url'],
        source: 'github'
      )]
    end
  end
end
