class PagesController < ApplicationController
  before_action :require_login, only: :home

  def welcome; end

  def home
    if session[:access_token].nil?
      tokens = helpers.get_access_refresh_token
      session[:access_token]  = tokens['access_token']
      session[:refresh_token] = tokens['refresh_token']
      session[:expire]        = Time.now
    end

    user_response = helpers.get_user(session[:access_token])
    session[:user_id] = user_response['id']
    @name             = user_response['display_name']
  end

  def auth
    url = 'https://accounts.spotify.com/authorize'
    params = {
      'client_id' => SPOTIFY_CLIENT_ID,
      'response_type' => 'code',
      'redirect_uri' => root_url + 'auth/spotify/callback',
      'scope' => 'playlist-modify-public playlist-modify-private user-follow-read'
    }
    redirect_to "#{url}?#{params.to_query}"
  end

  private

  def require_login
    if session[:user_id].nil? && params['code'].nil?
      redirect_to action: :welcome
    elsif session[:expire] && Time.now - Time.parse(session[:expire]) > 3300
      helpers.refresh_access_token
    end
  end
end
