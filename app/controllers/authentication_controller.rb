class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!

  def login
    redirect_to root_path
  end

  ['github', 'bitbucket'].each do |provider|
    define_method provider do
      oauth = request.env['omniauth.auth']
      session["#{provider}_oauth"] = {token: oauth.credentials.token, secret: oauth.credentials.secret}
      user = User.update_or_create_user_with_oauth(oauth)
      sign_in user, :event => :authentication
      redirect_to(request.env['omniauth.origin'] || projects_path)
    end
  end

  def logout
    reset_session
    sign_out current_user
    redirect_to root_path
  end
end
