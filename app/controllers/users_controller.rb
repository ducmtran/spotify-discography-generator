class UsersController < ApplicationController
  def oauth
    url = 'https://accounts.spotify.com/authorize'
    params = {
      'client_id' => SPOTIFY_CLIENT_ID,
      'response_type' => 'code',
      'redirect_uri' => root_url + '/auth/callback',
      'scope' => 'playlist-modify-public playlist-modify-private user-follow-read'
    }
    redirect_to "#{url}?#{params.to_query}"
  end
  
end
