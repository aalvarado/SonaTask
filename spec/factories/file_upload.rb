FactoryGirl.define do
  factory :file_upload, class: Hash do
    data { Base64.encode64(File.read('./spec/fixtures/text.txt')) }
    filename { 'text.txt' }
    content_type 'text/plain'
    initialize_with { attributes }
    to_create { self }
  end
end
