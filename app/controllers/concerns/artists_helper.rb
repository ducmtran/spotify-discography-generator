require 'rest-client'
module ArtistsHelper
  @track_names
  def search_artists(query)
    RSpotify::Artist.search(query)
  end

  def get_artist(id)
    RSpotify::Artist.find(id)
  end

  def create_playlist(id, tracks, artist_name)
    user = RSpotify::User.new({
      'id' => id,
      'credentials' => {
        'token' => session[:access_token],
        'access_token' => session[:refresh_token],
        'access_refresh_callback' => Proc.new {}
      }
    })

    playlist = user.create_playlist!("Discography - #{artist_name}")
    playlist.add_tracks!(tracks)
    playlist.name
  end

  def get_all_tracks_by_artist(artist)
    tracks = []
    artist.albums(album_type: 'album,single').each do |album|
      tracks += album.tracks
    end
    tracks.uniq { |track| track.name }
  end
end
