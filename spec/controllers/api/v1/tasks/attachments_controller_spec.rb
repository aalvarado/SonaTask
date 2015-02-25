require 'rails_helper'

describe Api::V1::Tasks::AttachmentsController do
  let( :user ) { create :user }
  let( :task ) { create :task, user: user }
  let( :attachment ) { create :attachment, task: task }
  let( :attachment_attr ) { { file: file_upload, } }

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
  end
end
