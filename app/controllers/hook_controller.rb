class HookController < ApplicationController
  skip_before_action :authenticate_user!
  respond_to :json

  def hook
    render :json => {:status => 'ok'}
  end
end
