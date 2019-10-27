require 'rest-client'
module ArtistsHelper
  @track_names
  def get_followed_artists(query)
    prms = {
      'q' => query,
      'type' => 'artist'
    }

    url = 'https://api.spotify.com/v1/search'
    res = RestClient.get(url +'?'+ prms.to_query, authorization_header)

    return JSON.parse(res.body)
  end

  def get_artist(id)
    url = "https://api.spotify.com/v1/artists/#{id}"
    res = RestClient.get(url, authorization_header)

    return JSON.parse(res.body)
  end

  def new_playlist(name)
    headers = authorization_content_header
    body = {"name" => "Discography - #{name}"}.to_json

    url = "https://api.spotify.com/v1/users/#{session[:user_id]}/playlists"
    res = RestClient.post(url, body, headers)
    
    return JSON.parse(res.body)
  end

  def get_all_albums_by_artist(id)
    url = "https://api.spotify.com/v1/artists/#{id}/albums?include_groups=album&country=US"
    res = RestClient.get(url, authorization_header)
    
    return JSON.parse(res.body)['items']
  end

  def get_all_tracks_in_album(album_id, playlist_id)
    url = "https://api.spotify.com/v1/albums/#{album_id}/tracks"
    res = RestClient.get(url, authorization_header)
    
    return tracks = JSON.parse(res.body)['items']
  end

  def add_tracks_to_playlist(playlist_id, track_uris)
    url = "https://api.spotify.com/v1/playlists/#{playlist_id}/tracks"
    headers = authorization_content_header
    body = {'uris' => track_uris}.to_json

    res = RestClient.post(url, body, headers)
  end

  private
  def authorization_header
    {authorization: "Bearer #{session[:access_token]}"}
  end

  def authorization_content_header
    {
      authorization: "Bearer #{session[:access_token]}",
      content_type: "application/json"
    }
  end
end
