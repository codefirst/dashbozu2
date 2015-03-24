module Dashbozu
  class InputCircleCI < Input
    Dashbozu::Plugin.register_input('circle_ci', self)

    def initialize
      super
    end

    def hook(project, params)
      p = params['payload']
      [Activity.new(
        project_id: project.id,
        title: "[Build] #{p['reponame']} - ##{p['build_num']} #{p['status'].capitalize}",
        body: p['subject'],
        url: p['build_url'],
        icon_url: GravatarImageTag.gravatar_url(p['committer_email']),
        author: p['committer_name'],
        status: p['status'] == 'success' || p['status'] == 'fixed' ? 'success' : 'error',
        source: 'circle_ci'
      )]
    end
  end
end
