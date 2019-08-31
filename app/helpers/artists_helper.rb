require 'rest-client'
module ArtistsHelper
  def get_followed_artists(query)
    prms = {
      'q' => query,
      'type' => 'artist'
    }

    url = 'https://api.spotify.com/v1/search'
    res = RestClient.get(url +'?'+ prms.to_query, {'Authorization' => "Bearer #{session[:access_token]}"})

    return JSON.parse(res.body)
  end

  def get_artist(id)
    url = "https://api.spotify.com/v1/artists/#{id}"
    res = RestClient.get(url, {'Authorization' => "Bearer #{session[:access_token]}"})

    return JSON.parse(res.body)
  end

  def new_playlist(name)
    headers = {
      authorization: "Bearer #{session[:access_token]}",
      content_type: "application/json"
    }
    body = {"name" => "Discography - #{name}"}.to_json

    url = "https://api.spotify.com/v1/users/#{session[:user_id]}/playlists"
    res = RestClient.post(url, body, headers)
    
    return JSON.parse(res.body)
  end

  def get_albums(id)
    url = "https://api.spotify.com/v1/artists/#{id}/albums?include_groups=album&country=US"
    res = RestClient.get(url, {authorization: "Bearer #{session[:access_token]}"})
    
    return JSON.parse(res.body)['items']
  end

  def get_tracks_and_add_to_playlist(album_id, playlist_id)
    url = "https://api.spotify.com/v1/albums/#{album_id}/tracks"
    res = RestClient.get(url, {authorization: "Bearer #{session[:access_token]}"})
    
    tracks = JSON.parse(res.body)['items']

    track_uris = []
    track_names = Set.new
    for t in tracks do
      if (!track_names.include?(t['name']))
        track_uris.append(t['uri'])
        track_names.add(t['name'])
      end
    end

    url = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
    headers = {
      authorization: "Bearer #{session[:access_token]}",
      content_type: "application/json"
    }
    body = {'uris' => track_uris}.to_json

    res = RestClient.post(url, body, headers)
  end
end
