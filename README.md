# Spotify Discography Generator

This is a simple rails application where an user can create a new discography playlist (all songs by an artist) to their spotify library

Running
------

1. Create an application on [Spotify's Developer Site](https://developer.spotify.com/my-applications/).

2. Add as redirect uris both http://127.0.0.1:3000/auth/callback (for development) on Spotify Developer Dashboard

3. Create `config/local_env.rb` file and add client_id and client_secret (from developer dashboard)

```ruby
# Local environment variables
# Ignore from commiting
ENV['client_id'] = 'client_id here'
ENV['client_secret'] = 'client_secret here'
```

4. Run `rails s`
