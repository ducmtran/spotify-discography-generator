require 'rest-client'
module PagesHelper
  def get_user(token_type, access_token)
    url = 'https://api.spotify.com/v1/me'
    res = RestClient.get(url, {authorization: "#{token_type} #{access_token}"})

    return JSON.parse(res.body)
  end

  def get_access_refresh_token
    uri = URI('https://accounts.spotify.com/api/token')
    prm = {
      'grant_type' => 'authorization_code',
      'code' => params['code'],
      'redirect_uri' => ENV['root_url'] + '/auth/callback',
      'client_id' => SPOTIFY_CLIENT_ID,
      'client_secret' => SPOTIFY_CLIENT_SECRET
    }
    res = Net::HTTP.post_form(uri, prm)
    return JSON.parse(res.body)
  end

  def refresh_access_token
    url = 'https://accounts.spotify.com/api/token'
    body = {
      'grant_type' => 'refresh_token',
      'refresh_token' => session[:refresh_token]
    }
    auth_str = Base64.strict_encode64(SPOTIFY_CLIENT_ID + ':' + SPOTIFY_CLIENT_SECRET)
    header = {
      authorization: "Basic #{auth_str}"
    }
    # body instead of body.to_json here because content-type is urlencoded
    res = RestClient.post(url, body, header)
    session[:access_token] = JSON.parse(res.body)['access_token']
  end


end

