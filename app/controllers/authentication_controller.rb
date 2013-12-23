class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!

  def login
    redirect_to root_path
  end

  Settings.omniauth.keys.each do |provider|
    define_method provider do
      authhash = request.env['omniauth.auth']
      auth = Auth.get_or_create_by_authhash(authhash)
      user = current_user || User.new
      user.connect_with(auth)
      sign_in user, :event => :authentication
      session["#{provider}_oauth_credentials"] = authhash.credentials
      redirect_to(request.env['omniauth.origin'] || projects_path)
    end
  end

  def logout
    reset_session
    sign_out current_user
    redirect_to root_path
  end
end
