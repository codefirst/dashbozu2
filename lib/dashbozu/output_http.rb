module Dashbozu
  class OutputHttp < Output
    Dashbozu::Plugin.register_output('http', self)

    def self.plugin_name
      'http'
    end

    config_param :url

    def initialize
      super
    end

    def emit(activities)
      return unless url
      conn = make_connection
      activities.each do |activity|
        post(conn, activity)
      end
    end

    private
    def make_connection
      Faraday::Connection.new(url: url) do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Logger
        builder.use Faraday::Adapter::NetHttp
      end
    end

    def post(connection, activity)
      connection.post do |request|
        request.headers['Content-Type'] = 'application/json'
        request.body = activity.to_json
      end
    end
  end
end

