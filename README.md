# SonaTask
[![Code Climate](https://codeclimate.com/github/aalvarado/SonaTask/badges/gpa.svg)](https://codeclimate.com/github/aalvarado/SonaTask)
[![Test Coverage](https://codeclimate.com/github/aalvarado/SonaTask/badges/coverage.svg)](https://codeclimate.com/github/aalvarado/SonaTask)

User and Tasks Rails API using PostgreSQL Database with Full Text Search support through the `pg_trgm` module which Textacular uses to search through Task body column.

The `tasks_controller` class lists how a user may interact with their associated tasks. 

Please review the `specs` folder for more insight into the details on how this works as well as the example using Faraday at the bottom of the page.

## Prerequisites

- Rbenv & ruby-build
- Postgresql >= 9
- Postgresql contrib
- Imagemagick or Minimagick
- Some command line experience

## Recommendations

- Passenger and Nginx
- Dnsmasq
- Faraday (`gem install faraday`)
- Pry

## How to setup

```
git clone https://github.com/aalvarado/SonaTask.git sonatask

cd sonatask
bundle install
```

Create the `config/secrets.yml` and `config/initializers/secret_token.rb` files

Start Postgresql and copy `config/database.yml` from `config/database.yml.example`.

`bundle exec rake db:setup`

Run Rails

`bundle exec rails s`

### Nginx setup

create a key and cert:

```
openssl req -new -newkey rsa:2048 -sha1 -days 365 -nodes -x509 -keyout sonatask.key -out sonatask.crt
```

nginx conf

```
# Adjust paths to your own setup

server {
  server_name sonatask.dev *.sonatask.dev;
  listen 80;
  return 301 https://$server_name$request_uri;
}

server {
  server_name sonatask.dev *.sonatask.dev;
  listen 443 ssl;

  passenger_ruby /home/adan/.rbenv/versions/2.2.0/bin/ruby;

  passenger_enabled on;
  passenger_app_env development;

  root /home/adan/projects/adan/sonatask/public;

  access_log access.log combined;
  error_log  error.log;

  ssl_certificate     ../ssl/sonatask.crt;
  ssl_certificate_key ../ssl/sonatask.key;
}
```

## Some usage


```ruby
# pry for example

#you might want to set the content type on each request or use some faraday middle ware
require 'faraday'; conn = Faraday.new( url: 'https://sonatask.dev', :ssl => {:verify => false } ) { |f| f.request :url_encoded; f.response :logger;  f.adapter Faraday.default_adapter }
conn.post '/auth', { email: 'some@dev.dev', password: 'password' }
conn.post '/auth/sign_in', { email: 'some@dev.dev', password: 'password' }
conn.delete '/auth/sign_out', {}, {'access-token' => '7LBVZufvDJHwhxBwQFf31w', 'uid' => 'some@dev.dev', 'client' => '8IOJ4Uv1pVUUxQWay-MNLg' }
```
## Rspec customizations

- All requests in `spec/controllers/api` are set `['HTTP_ACCEPT'] = 'application/json'` request header.
- `login_user` sets auth headers in request. ( `access-token`, `client`, `uid` ).
- `response_body_object` parses the body of response as JSON and into an `OpenStruct` object.
- I like to keep `let` and `expect` with spaces between parenthesis
- The carrierwave uploader's store_dir location is modified for tests and removed at the end of the suite
