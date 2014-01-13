class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  def credentials_by(provider)
    session["#{provider}_oauth_credentials"]
  end

  def logged_provider
    Settings.omniauth.keys.each do |provider|
      return provider if session.has_key?("#{provider}_oauth_credentials")
    end
    nil
  end
end
