class ArtistsController < ApplicationController
  def show
    spotify_user = RSpotify::User.new(response.env['omniauth.auth'])
  end
  
  def search_result
    rlt = helpers.get_followed_artists(params['search']['query'])
    @all_artists = rlt['artists']['items']
  end

  def create_playlist
    artist_id = params[:id]
    artist = helpers.get_artist(artist_id)

    playlist = helpers.new_playlist(artist['name'])

    albums = helpers.get_albums(artist_id)

    for album in albums do
      helpers.get_tracks_and_add_to_playlist(album['id'], playlist['id'])
    end

    redirect_to home_path(), flash: { success: "Playlist '#{playlist['name']}' created!"}
  end

end
