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
      client = Faraday.new(url: "#{uri.scheme}://#{uri.host}:#{uri.port}")
      client.post(uri.path, make_body(activity))
    end

    def make_url
      "#{url}/api/v1/message.json"
    end

    def make_body(activity)
      {
        room_id: room_id,
        api_key: api_key,
        message: make_message(activity)
      }
    end

    def make_message(activity)
      erb = ERB.new(message_template || "<%= activity.html_url %>")
      erb.result(binding)
    end

  end
end

