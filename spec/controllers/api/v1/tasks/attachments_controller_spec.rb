require 'rails_helper'

describe Api::V1::Tasks::AttachmentsController do
  let( :user ) { create :user }
  let( :task ) { create :task, user: user }
  let( :attachment ) { create :attachment, task: task }
  let( :attachment_attr ) { { file: create(:file_upload) } }

  context 'logged in user' do
    before do
      login_user user
    end

    describe 'show' do
      before do
        get :show, id: attachment.id, task_id: task.id
      end

      it{ expect( response ).to be_success }
    end

    describe 'index' do
      before do
        attachment
        get :index, task_id: task.id
      end

      it{ expect( response ).to be_success }
      it 'returns the right attachment list' do
        expect( response_body_object['attachments'].count ).to eq 1
      end
    end

    describe 'create ' do
      before do
        post :create, task_id: task.id, attachment: attachment_attr
      end

      it{ expect( response ).to be_success }
      it 'returns the right attachment' do
        expect( response_body_object.attachment['id'] ).to be_present
        expect( response_body_object.attachment['file'] ).to be_present
      end
    end

    describe 'update' do
      before do
        put :update, task_id: task.id, id: attachment.id, attachment: attachment_attr
      end

      it{ expect( response ).to be_success }
    end

    describe 'destroy' do
      before do
        delete :destroy, task_id: task.id, id: attachment.id
      end

      it{ expect( response ).to be_success }
    end
  end

  context 'when not logged in' do
    describe 'get' do
      before do
        get :show, id: attachment.id, task_id: task.id
      end

      it{ expect( response.status ).to eq 401 }
    end

    describe 'index' do
      before do
        task
        get :index, task_id: task.id
      end

      it{ expect( response.status ).to eq 401 }
    end

    describe 'update' do
      before do
        put :update, task_id: task.id, id: attachment.id, attachment: attachment_attr
      end

      it{ expect( response.status ).to eq 401 }
    end

    describe 'destroy' do
      before do
        task
        delete :destroy, task_id: task.id, id: attachment.id
      end

      it{ expect( response.status ).to eq 401 }
    end
  end
end
