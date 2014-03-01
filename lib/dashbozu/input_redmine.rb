module Dashbozu
  class InputRedmine < Input
    Dashbozu::Plugin.register_input('redmine', self)

    def initialize
      super
    end

    def hook(project, params)
      return [] unless params['payload']

      payload = params['payload']

      if payload['action'] == 'opened'
        return hook_opened(project, payload)
      else payload['action'] == 'updated'
        return hook_updated(project, payload)
      end
      return []
    end

    def hook_opened(project, payload)
      return [] unless payload['issue']
      return [] unless payload['issue']['author']

      issue   = payload['issue']
      author  = issue['author']
      [Activity.new(
        project_id: project.id,
        title: "[Issue] #{issue['project']['name']} - ##{issue['id']} #{payload['action']}: #{issue['subject']}",
        body: issue['description'],
        url: payload['url'],
        author: author['login'],
        icon_url: payload['icon_url'],
        source: 'redmine'
      )]
    end

    def hook_updated(project, payload)
      return [] unless payload['issue']
      return [] unless payload['journal']
      return [] unless payload['issue']['author']

      issue   = payload['issue']
      journal = payload['journal']
      author  = issue['author']
      [Activity.new(
        project_id: project.id,
        title: "[Issue] #{issue['project']['name']} - ##{issue['id']} #{payload['action']}: #{issue['subject']}",
        body: journal['notes'],
        url: payload['url'],
        author: author['login'],
        icon_url: payload['icon_url'],
        source: 'redmine'
      )]
    end
  end
end
