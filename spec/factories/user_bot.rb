FactoryBot.define do
  factory :user do
    sequence(:email) { "test@gmail.com" }
    password { "123456" }
  end
end
