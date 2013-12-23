class AuthenticationController < ApplicationController
  skip_before_action :authenticate_user!

  def login
    redirect_to root_path
  end

  ['github', 'bitbucket'].each do |provider|
    define_method provider do
      oauth = request.env['omniauth.auth']
      auth = Auth.get_or_create_by_oauth(oauth)
      user = auth.user
      unless user
        user = User.create!
        user.auths << auth
      end
      sign_in user, :event => :authentication
      session["#{provider}_oauth"] = {token: oauth.credentials.token, secret: oauth.credentials.secret}
      redirect_to(request.env['omniauth.origin'] || projects_path)
    end
  end

  def logout
    reset_session
    sign_out current_user
    redirect_to root_path
  end
end
