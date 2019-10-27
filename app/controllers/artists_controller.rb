class ArtistsController < ApplicationController
  include ArtistsHelper
  include PagesHelper
  
  def search_result
    rlt = helpers.get_followed_artists(params['search']['query'])
    @all_artists = rlt['artists']['items']
  end

  def create_playlist
    artist_id = params[:id]
    artist = get_artist(artist_id)

    playlist = new_playlist(artist['name'])
    albums = get_all_albums_by_artist(artist_id)

    track_uris = []
    track_names = Set.new

    for album in albums do
      tracks = get_all_tracks_in_album(album['id'], playlist['id'])
      for t in tracks do
        if (!track_names.include?(t['name']))
          track_uris.append(t['uri'])
          track_names.add(t['name'])
        end
      end
    end

    add_tracks_to_playlist(playlist['id'], track_uris)

    redirect_to home_path(), flash: { success: "Playlist '#{playlist['name']}' created!"}
  end

end
