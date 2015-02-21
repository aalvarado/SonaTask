class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include AbstractController::Callbacks
  include ActionController::StrongParameters
end
