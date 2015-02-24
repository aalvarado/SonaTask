require 'rails_helper'

describe Api::V1::TasksController do
  let( :user ) { create :user }
  let( :task ) { create :task, user: user }
  let( :task_attr ) do
    {
      title: 'foo',
      body: 'bar',
      expiration: Time.now.utc.as_json,
      completed_on: Time.now.utc.as_json,
      position: 1
    }
  end

  context 'logged in user' do
    before do
      login_user user
    end

    describe 'show' do
      before do
        get :show, id: task.id
      end

      it{ expect( response ).to be_success }

      it 'returns the right task' do
        expect( response_body_object.task['id'] ).to eq task.id
      end
    end

    describe 'index' do
      before do
        task
        get :index
      end

      it{ expect( response ).to be_success }

      it 'returns the right task list' do
        expect( response_body_object['tasks'].count ).to eq 1
      end

    end

    describe 'create' do

      before do
        post :create, task: task_attr
      end

      it{ expect( response ).to be_success }
    end

    describe 'update' do
      before do
        put :update, id: task.id, task: task_attr
      end

      it{ expect( response ).to be_success }

      it 'returns the task with updated attributes' do
        get :show, id: task.id

        task_attr.each do |k,v|
          expect( response_body_object['task'].send :[], k.to_s ).to eq v
        end
      end

      it 'success even if attribute not on permitted params' do
        put :update, id: task.id, task: task_attr.merge({ invalid: 'invalid' })
        expect( response ).to be_success
      end
    end
  end #logged in user context
end
