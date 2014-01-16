module Dashbozu
  class InputErrbit < Input
    Dashbozu::Plugin.register_input('errbit', self)

    def initialize
      super
    end

    def hook(project, params)
      payload_body = params[:problem]
      p = MultiJson.load(payload_body)
      [Activity.new(
        project_id: project.id,
        title: "[Error] #{p['app_name']} - #{p['error_class']}",
        body: p['message'],
        status: 'error',
        source: 'errbit'
      )]
    end
  end
end
