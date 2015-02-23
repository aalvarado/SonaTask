require 'rails_helper'

describe DeviseTokenAuth::SessionsController do
  let(:password) { 'password' }
  let(:email) { 'some@email.dev' }
  let(:auth_attr ) { { email: email, password: password } }
  let!(:user) { create :user, auth_attr }

  before do
     @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'post' do
    context 'valid email and password' do
      it 'is successful' do
        post :create, auth_attr
        expect( response ).to be_success
      end
    end

    context 'invalid email' do
      let( :invalid_email ) { { email: 'invalid@email.dev' } }

      before do
        auth_attr.merge!(invalid_email)
      end

      it 'is 401' do
        post :create, auth_attr
        expect( response.status ).to eq 401
      end
    end

    context 'invalid password' do
      let( :invalid_password ) { { password: 'invalid' } }

      before do
        auth_attr.merge!(invalid_password)
      end

      it 'is 401' do
        post :create, auth_attr
        expect( response.status ).to eq 401
      end

    end
  end
end
