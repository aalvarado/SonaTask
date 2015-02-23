module Support
  module ControllerMacros
    def login_user user
      token = user.create_new_auth_token
      request.headers.merge! token
    end

    def response_body_object
      OpenStruct.new( JSON.parse(response.body) )
    end
  end
end
