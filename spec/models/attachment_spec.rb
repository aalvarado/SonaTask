require 'rails_helper'

describe Attachment do
  let( :attachment ) { create :attachment }

  describe :file do
    it 'must be present' do
      attachment = build :attachment, file: nil
      expect( attachment ).to be_invalid
    end

    it 'is stored properly' do
      expect( attachment.file.read ).to eq File.read('./spec/fixtures/text.txt')
    end
  end

  describe :task do
    it{ expect( attachment ).to validate_presence_of(:task) }
    it{ expect( attachment.task ).to be_a Task }
  end
end
