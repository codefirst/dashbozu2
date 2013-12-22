module Dashbozu
  class InputGitHub < Input
    Dashbozu::Plugin.register_input('github', self)

    def initialize
      super
    end

    def hook(project, payload_body)
      json = MultiJson.load(payload_body)
      repos_name = json['repository']
      json['commits'].map do |c|
        Activity.new(
          project: project,
          title: "#{repos_name} / #{c['id'][0..8]}",
          body: c['message'],
          url: c['url'],
          author: c['author'],
          source: 'github'
       )
      end
    end
  end
end
