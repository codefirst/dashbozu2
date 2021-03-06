module Dashbozu
  class InputWercker < Input
    Dashbozu::Plugin.register_input('wercker', self)

    def initialize
      super
    end

    def hook(project, params)
      [Activity.new(
        project_id: project.id,
        title: "[#{params[:type].capitalize}] #{params[:application_name]} - #{params[:result]}",
        body: params[:git_branch],
        url: params[:build_url],
        status: params[:result] == 'passed' ? 'success' : 'error',
        author: params[:started_by],
        source: 'wercker'
      )]
    end
  end
end
