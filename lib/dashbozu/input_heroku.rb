module Dashbozu
  class InputHeroku < Input
    Dashbozu::Plugin.register_input('heroku', self)

    def initialize
      super
    end

    def self.scope
      :project
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "[Deploy] #{params[:app]} - #{params[:head]}",
        body: params[:git_log],
        url: params[:url],
        icon_url: GravatarImageTag.gravatar_url(params[:user]),
        author: params[:user],
        source: 'heroku'
      )]
    end
  end
end
