module Dashbozu
  class InputDploy < Input
    Dashbozu::Plugin.register_input('dploy', self)

    def initialize
      super
    end

    def hook(project, params)
      return [] if params.keys.empty?
      payload = JSON.load(params.keys.first)
      [Activity.new(
        project_id: project.id,
        title: "[Deploy] #{payload['repository']} - #{payload['revision'][0..8]} : #{payload['server']}",
        body: payload['comment'],
        url: '',
        author: payload['author_name'],
        icon_url: GravatarImageTag.gravatar_url(payload['author_email']),
        source: 'dploy'
      )]
    end
  end
end
