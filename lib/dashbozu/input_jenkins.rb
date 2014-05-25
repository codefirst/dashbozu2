module Dashbozu
  class InputJenkins < Input
    Dashbozu::Plugin.register_input('jenkins', self)

    def initialize
      super
    end

    def self.scope
      :project
    end

    def hook(project, params)
      build = params['hook']
      return [] unless build['build']['phase'] == 'FINISHED'
      [Activity.new(
        project_id: project.id,
        title: "[Build] #{build['name']} - ##{build['build']['number']} #{build['build']['status'].capitalize}",
        body: build['build']['status'],
        url: build['build']['full_url'],
        author: build['build']['url'],
        status: status(build),
        source: 'jenkins'
      )]
    end

    private
    def status(build)
      status = build['build']['status']
      if status == 'FAILURE'
        return 'error'
      elsif status == 'UNSTABLE'
        return 'error'
      elsif status == 'SUCCESS'
        return 'success'
      else
        return ''
      end
    end
  end
end
