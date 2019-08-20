class UsersController < ApplicationController
  def oauth
    url = 'https://accounts.spotify.com/authorize'
    params = {
      'client_id' => '588322e3bff442fbbdda5765390d0f24',
      'response_type' => 'code',
      'redirect_uri' => ENV['root_url'] + '/auth/callback',
      'scope' => 'playlist-modify-public playlist-modify-private user-follow-read'
    }
    redirect_to "#{url}?#{params.to_query}"
  end
  
end
