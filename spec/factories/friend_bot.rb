FactoryBot.define do
  factory :friend do
    association :user
    name {"123456"}
  end
end
