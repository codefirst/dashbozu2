module Dashbozu
  class InputMackerel < Input
    Dashbozu::Plugin.register_input('mackerel', self)

    def initialize
      super
    end

    def hook(project, params)
      json = params

      alert = json['alert']
      host = json['host']

      return [] if json.nil? or alert.nil? or host.nil?

      [Activity.new(
          project_id: project.id,
          title: "[Mackerel] #{alert['status'].upcase}: #{alert['monitorName']}",
          body: "#{host['name']} (#{host['status']})",
          url: alert['url'],
          status: alert['isOpen'] ? 'error' : 'success',
          source: 'mackerel'
      )]
    end
  end
end
