require 'rails_helper'

describe Task do
  let( :task ) { create :task }

  describe :title do
    it{ expect( task ).to validate_presence_of(:title) }
  end

  describe :body do
    let( :task ) { create :task, body: 'Some text body foobar' }

    it{ expect( task ).to validate_presence_of(:body) }

    it 'can be searched' do
      results = Task.basic_search(body: 'foobar')
      expect( results ).to include(task)
    end

    it 'can be fuzzy searched' do
      results = Task.fuzzy_search(body: 'bod fooba')
      expect( results ).to include(task)
    end
  end

  describe :user do
    it{ expect( task ).to validate_presence_of(:user) }
    it 'must be a valid user association' do
      task = build :task, user_id: 0
      expect( task ).to be_invalid
    end
  end

  describe :position do
    it 'can be blank' do
      task = build :task, position: nil
      expect( task ).to be_valid
    end
  end

  describe :expiration do
    it 'can be blank' do
      task = build :task, expiration: nil
      expect( task ).to be_valid
    end
  end

  describe :completed_on do
    it 'can be blank' do
      task = build :task, completed_on: nil
      expect( task ).to be_valid
    end
  end
end
