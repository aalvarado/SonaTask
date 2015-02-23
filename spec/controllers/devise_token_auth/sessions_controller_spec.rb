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
        expect(response).to be_success
      end
    end

    context 'invalid email' do
      let( :invalid_email ) { { email: 'invalid@email.dev' } }

      before do
        auth_attr.merge!(invalid_email)
      end

      it 'is 401' do
        post :create, auth_attr
        expect(response.status).to eq 401
      end
    end

    context 'invalid password' do
      let( :invalid_password ) { { password: 'invalid' } }

      before do
        auth_attr.merge!(invalid_password)
      end

      it 'is 401' do
        post :create, auth_attr
        expect(response.status).to eq 401
      end

    end
  end

  describe 'delete' do
    let( :auth_header ) { user.create_new_auth_token }

    before do
      request.headers.merge! auth_header
    end

    context 'correct token header' do

      it 'is success' do
        delete :destroy
        expect(response).to be_success
      end
    end

    context 'wrong token' do
      before do
        request.headers['access-token'] = 'invalid'
      end

      shared_examples_for 'invalid_auth_data' do
        it 'is 404' do
          delete :destroy
          expect(response.status).to eq 404
        end
      end
    end

    context 'wrong uid' do
      before do
        request.headers['uid'] = 'invalid'
      end

      it 'is 404' do
        delete :destroy
        expect(response.status).to eq 404
      end
    end

    context 'wrong client' do
      before do
        request.headers['client'] = 'invalid'
      end

      it 'is 404' do
        delete :destroy
        expect(response.status).to eq 404
      end
    end
  end
end
