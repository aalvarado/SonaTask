Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  # TODO: how to specify header value based on env?
  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/vnd.sonatask.dev; version=1"}) do

  end
end
