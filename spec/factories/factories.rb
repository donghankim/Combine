FactoryBot.define do
    factory :user do
      sequence(:email) { "test@gmail.com" }
      password { "rokmc1214" }
    end
  end
