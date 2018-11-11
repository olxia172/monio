FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password { 'asdfgh123' }
    password_confirmation { 'asdfgh123' }
  end
end
