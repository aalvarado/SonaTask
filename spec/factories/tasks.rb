FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "My Title #{1}" }
    sequence(:body) { |n| "Task body #{1}" }
    user
  end
end
