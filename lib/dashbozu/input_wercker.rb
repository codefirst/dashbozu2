module Dashbozu
  class InputWercker < Input
    Dashbozu::Plugin.register_input('wercker', self)

    def initialize
      super
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "[#{params[:type]}] #{params[:application_name]} - #{params[:result]}",
        body: params[:git_branch],
        url: 'http://example.com',
        status: params['status_message'] == 'passed' ? 'success' : 'error',
        author: params[:started_by],
        source: 'wercker'
      )]
    end
  end
end
