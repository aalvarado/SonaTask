class ApplicationController < ActionController::API
  include AbstractController::Callbacks
  include ActionController::StrongParameters
  include ActionController::RespondWith
end
