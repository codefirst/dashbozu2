module Dashbozu
  class InputDploy < Input
    Dashbozu::Plugin.register_input('dploy', self)

    def initialize
      super
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "[Deploy] #{params['repository']} - ##{params['revision']} : #{params['server']}",
        body: params['comment'],
        url: '',
        author: params['author_name'],
        icon_url: '',
        source: 'dploy'
      )]
    end

  end
end
