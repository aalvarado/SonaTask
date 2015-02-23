FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "foo#{n}@email.dev" }
    password 'password'
    uid { email }
    provider 'email'
  end
end
