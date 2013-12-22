module Dashbozu
  class InputHeroku < Input
    Dashbozu::Plugin.register_input('heroku', self)

    def initialize
      super
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "#{params[:app]} - #{params[:head]}",
        body: params[:git_log],
        url: params[:url],
        author: params[:user],
        source: 'heroku'
      )]
    end
  end
end
