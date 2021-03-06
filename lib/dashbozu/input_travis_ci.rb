module Dashbozu
  class InputTravisCI < Input
    Dashbozu::Plugin.register_input('travis_ci', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:payload]
      p = MultiJson.load(payload_body)
      repos_name = p['repository']['name']
      repos_owner = p['repository']['owner_name']
      [Activity.new(
        project_id: project.id,
        title: "[Build] #{repos_name} - ##{p['number']} #{p['status_message']}",
        body: p['message'],
        url: "https://travis-ci.org/#{repos_owner}/#{repos_name}/builds/#{p["id"]}",
        icon_url: GravatarImageTag.gravatar_url(p['author_email']),
        author: p['author_name'],
        status: p['status_message'] == 'Fixed' || p['status_message'] == 'Passed' ? 'success' : 'error',
        source: 'travis_ci'
      )]
    end
  end
end
