# Load the Rails application.
require_relative 'application'
require File.join(File.dirname(__FILE__), 'boot')

# Load heroku vars from local file
local_env = File.join(Rails.root, 'config', 'local_env.rb')
load(local_env) if File.exists?(local_env)

# Initialize the Rails application.
Rails.application.initialize!

