FactoryGirl.define do
  factory :attachment do
    task
    file File.open('./spec/fixtures/text.txt')
  end
end
