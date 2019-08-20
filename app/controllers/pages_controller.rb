class PagesController < ApplicationController
  def welcome
    if session[:expire]
      redirect_to :home
    end
  end

  def home
    if Time.now - Time.parse(session[:expire]) > 3300
      helpers.refresh_access_token()
    end
    # token params contains access_token, token_type, scope, expires, refresh_token
    user_param = helpers.get_user('Bearer', session[:access_token])
    session[:user_id] = user_param['id']
    @name = user_param['display_name']
    @profile_image
    if user_param['images'].length > 0
      @profile_image = user_param['images'][0]['url']
    end
  end

  def redirect_to_home
    token_params = helpers.get_access_refresh_token()
    session[:access_token] = token_params['access_token']
    session[:refresh_token] = token_params['refresh_token']
    session[:expire] = Time.now
    redirect_to action: :home
  end
end
