require 'rails_helper'

describe DeviseTokenAuth::RegistrationsController do
  let( :password ) { 'password' }
  let( :email ) { 'some@email.dev' }
  let( :auth_attr ) { { email: email, password: password } }

  describe 'auth' do
    context 'with correct email and password' do
      it 'is successful' do
        post :create, auth_attr
        expect( response ).to be_success
      end

      it 'returns token information' do
        post :create, auth_attr
        expect( response.headers['access-token'] ).to be_present
        expect( response.headers['client'] ).to be_present
        expect( response.headers['uid'] ).to be_present
        expect( response.headers['token-type'] ).to eq 'Bearer'
      end
    end

    context 'with missing email' do
      before do
        auth_attr.merge! email: ''
      end
      it 'is eql 401' do
        post :create, auth_attr
        expect( response.status ).to eq 403
      end
    end
  end
end
