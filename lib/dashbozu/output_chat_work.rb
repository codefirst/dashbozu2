require 'erb'
module Dashbozu
  class OutputChatWork < Output
    Dashbozu::Plugin.register_output('chat_work', self)

    def self.plugin_name
      'chat_work'
    end

    config_param :token
    config_param :room_id
    config_param :message_template

    def initialize
      super
    end

    def emit(activities)
      return unless token
      conn = make_connection
      activities.each do |activity|
        post(conn, activity)
      end
    end

    def post(connection, activity)
      connection.post do |request|
        request.url "/v1/rooms/#{room_id}/messages"
        request.headers = { 'X-ChatWorkToken' => token }
        request.params[:body] = make_message(activity)
      end
    end

    def make_connection
      Faraday::Connection.new(url: 'https://api.chatwork.com') do |builder|
        builder.use Faraday::Request::UrlEncoded
        builder.use Faraday::Response::Logger
        builder.use Faraday::Adapter::NetHttp
      end
    end

    def make_message(activity)
      erb = ERB.new(message_template)
      erb.result(binding)
    end
  end
end

