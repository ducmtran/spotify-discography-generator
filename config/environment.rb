# Load the Rails application.
require_relative 'application'
require File.join(File.dirname(__FILE__), 'boot')

require 'omniauth'

SPOTIFY_CLIENT_ID = ENV['SPOTIFY_CLIENT_ID']
SPOTIFY_CLIENT_SECRET = ENV['SPOTIFY_CLIENT_SECRET']

# Initialize the Rails application.
Rails.application.initialize!

RSpotify::authenticate(SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET)