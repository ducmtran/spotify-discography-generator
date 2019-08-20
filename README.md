# Spotify Discography Generator

This is a simple rails application where an user can create a new discography playlist (all songs by an artist) to their spotify library

Try it here https://spotify-discography-generator.herokuapp.com

Running
------

1. Create an application on [Spotify's Developer Site](https://developer.spotify.com/my-applications/).

2. Add redirect url http://127.0.0.1:3000/auth/callback in Spotify Developer Dashboard

3. Create `config/local_env.rb` file and add client_id and client_secret (from developer dashboard)

```ruby
# Local environment variables
# Ignore from commiting in .gitignore
ENV['client_id'] = #client_id here
ENV['client_secret'] = #client_secret here
ENV['root_url'] = 'http://127.0.0.1:3000'
```

4. Run `rails s`
