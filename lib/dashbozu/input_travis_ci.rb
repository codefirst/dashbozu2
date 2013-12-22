module Dashbozu
  class InputTravisCI < Input
    Dashbozu::Plugin.register_input('travis_ci', self)

    def initialize
      super
    end

    def payload
      'payload'
    end

    def hook(project, payload_body)
      p = MultiJson.load(payload_body)['payload']
      repos_name = p['repository']['name']
      repos_owner = p['repository']['owner_name']
      [Activity.new(
        project: project.id,
        title: "#{p['status_message']}",
        body: p['message'],
        url: "https://travis-ci.org/#{repos_owner}/#{repos_name}/builds/#{p["id"]}",
        author: p['author_name'],
        status: p['status_message'] == 'Passed' ? 'success' : 'failure',
        source: 'travis_ci'
      )]
    end
  end
end
