class HookController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def hook
    name = params[:name]
    input_plugin = Dashbozu::Plugin.input[name]
    unless input_plugin
      render json: {status: 'error', message: 'name not found'}, status: 404
      return
    end

    input_plugin = input_plugin.new

    payload = params[input_plugin.payload]
    unless payload
      render json: {status: 'error', message: 'payload not found'}, status: 404
      return
    end

    api_key = params[:api_key]
    project = Project.find_by_api_key api_key if api_key
    if api_key == nil || project == nil
      render json: {status: 'error', message: 'invalid api key'}, status: 403
      return
    end

    activities = input_plugin.hook(project, payload)
    activities.each do |activity|
      Rails.logger.info activity.to_json
      activity.save!
    end

    output_plugins = Dashbozu::Plugin.output.values
    output_plugins.each do |output_plugin|
      output_plugin.new.emit(activities)
    end

    render json: {status: 'ok'}
  end
end
