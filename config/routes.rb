Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  # TODO: how to specify header (vnd.sonatask.dev) value based on env?
  api_version(:module => "Api::V1", :header => {:name => "Accept", :value => "application/vnd.sonatask.dev; version=1"}, default: true) do
    resources :tasks
  end
end
