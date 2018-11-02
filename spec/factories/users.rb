FactoryBot.define do
  factory :user do
    email { "email@example.com" }
    password { 'asdfgh123' }
    password_confirmation { 'asdfgh123' }
  end
end
