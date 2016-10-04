class ApiController < ActionController::API
  include AbstractController::Callbacks
  include ActionController::StrongParameters
  include ActionController::RespondWith
  include ActionController::Serialization
  include ActionController::ImplicitRender

  include DeviseTokenAuth::Concerns::SetUserByToken

  respond_to :json
end
