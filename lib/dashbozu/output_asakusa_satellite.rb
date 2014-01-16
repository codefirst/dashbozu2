require 'erb'
module Dashbozu
  class OutputAsakusaSatellite < Output
    Dashbozu::Plugin.register_output('asakusa_satellite', self)

    def self.plugin_name
      'asakusa_satellite'
    end

    config_param :url
    config_param :api_key
    config_param :room_id
    config_param :message_template

    def initialize
      super
    end

    def emit(activities)
      return unless url
      activities.each do |activity|
        post(activity)
      end
    end

    def post(activity)
      uri = URI.parse(make_url)
      Net::HTTP.start(uri.host, uri.port) do |http|
        http.post(uri.path, make_body(activity))
      end
    end

    def make_url
      "#{url}/api/v1/message.json"
    end

    def make_body(activity)
      [
        "room_id=#{room_id}",
        "api_key=#{api_key}",
        "message=#{escape(make_message(activity))}"
      ].join("&")
    end

    def make_message(activity)
      erb = ERB.new(message_template)
      erb.result(binding)
    end

    def escape(str)
      URI.escape(URI.escape(str), /[&+]/)
    end
  end
end

