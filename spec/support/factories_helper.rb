# FactoryBot.define do
#   initialize_with { new(attributes) }
# end

FactoryBot.define do
  factory :user do
    #sequence(:email) { |n| "test-#{n.to_s.rjust(3, "0")}@sample.com" }
    sequence(:email) { "test@sample.com" }
    password { "rokmc1214" }
  end
end
