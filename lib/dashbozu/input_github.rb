module Dashbozu
  class InputGitHub < Input
    Dashbozu::Plugin.register_input('github', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:payload]
      json = MultiJson.load(payload_body)
      repos_name = json['repository']['name']
      json['commits'].map do |c|
        Activity.new(
          project_id: project.id,
          title: "#{repos_name} / #{c['id'][0..8]}",
          body: c['message'],
          url: c['url'],
          author: c['author']['username'],
          source: 'github'
       )
      end
    end
  end
end
