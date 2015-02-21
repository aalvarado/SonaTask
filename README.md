# SonaTask
SonaTask


## Prerequisites

- Rbenv & ruby-build
- Postgresql >= 9
- Some command line experience

## Recommendations

- Passenger and Nginx
- Dnsmasq
- Faraday (`gem install faraday`)
- Pry

## How to setup

`git clone https://github.com/aalvarado/SonaTask.git sonatask`

`cd sonatask`

`bundle install`

Create a postgresql and create `config/database.yml`, an example is provided at `config/database.yml.example`.

`bundle exec rake db:setup`

Run Rails

`bundle exec rails s`

## Some usage


```ruby
# pry for example

require 'faraday'; conn = Faraday.new( url: 'http://sonatask.dev' ) { |f| f.request :url_encoded; f.response :logger;  f.adapter Faraday.default_adapter }
conn.post '/auth', { email: 'some@dev.dev', password: 'password' }
conn.post '/auth/sign_in', { email: 'some@dev.dev', password: 'password' }
conn.delete '/auth/sign_out', {}, {'access-token' => '7LBVZufvDJHwhxBwQFf31w', 'uid' => 'some@dev.dev', 'client' => '8IOJ4Uv1pVUUxQWay-MNLg' }
```


