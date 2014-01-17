module Dashbozu
  class InputJenkins < Input
    Dashbozu::Plugin.register_input('jenkins', self)

    def initialize
      super
    end

    def hook(project, params)
require 'pp'
pp params
      return [] unless params['build']['phase'] == 'COMPLETED'
      [Activity.new(
        project_id: project.id,
        title: "[Build] #{params['name']} - ##{params['build']['number']} #{params['build']['status'].capitalize}",
        url: params['build']['full_url'],
        author: params['build']['url'],
        status: status(params),
        source: 'jenkins'
      )]
    end

    private
    def status(params)
      if params['build']['status'] == 'FAILURE'
        return 'error'
      elsif params['build']['status'] == 'UNSTABLE'
        return 'error'
      elsif params['build']['status'] == 'SUCCESS'
        return 'success'
      else
        return ''
      end
    end
  end
end
