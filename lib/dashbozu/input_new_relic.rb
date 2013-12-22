module Dashbozu
  class InputNewRelic < Input
    Dashbozu::Plugin.register_input('new_relic', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:alert]
      return [] unless payload_body
      a = MultiJson.load(payload_body)
      [Activity.new(
        project_id: project.id,
        title: "#{a['application_name']}: #{a['message']}",
        body: a['long_description'],
        url: a['alert_url'],
        author: a['account_name'],
        status: 'alert',
        source: 'new_relic'
      )]
    end
  end
end
