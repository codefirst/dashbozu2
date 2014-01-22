module Dashbozu
  class InputSunline < Input
    Dashbozu::Plugin.register_input('sunline', self)

    def initialize
      super
    end

    def hook(project, params)
      json = MultiJson.load(params[:payload])
      body = tail_lines(json['log']['result'], 3)
      [Activity.new(
        project_id: project.id,
        title: "[Sunline] #{json['script']['name']} - #{json['log']['host']}",
        body: body,
        url: "#{json['url']}",
        author: nil,
        icon_url: nil,
        source: 'sunline'
      )]
    end

    private
    def tail_lines(text, num)
      lines = text.split("\n")
      return lines.join("\n") if lines.size < 3
      lines[-3..-1].join("\n")
    end
  end
end
