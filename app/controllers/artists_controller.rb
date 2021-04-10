class ArtistsController < ApplicationController
  include ArtistsHelper
  include PagesHelper
  
  def search_result
    @found_artists_by_name = search_artists(params['search']['query'])
  end

  def create_discography
    artist = get_artist(artist_id)
    tracks = get_all_tracks_by_artist(artist)

    playlist_name = create_playlist(user_id, tracks, artist.name)

    redirect_to home_path(), flash: { success: "#{playlist_name} created!" }
  end

  private

  def artist_id
    params[:id]
  end

  def user_id
    session[:user_id]
  end
end
