FactoryBot.define do
  factory :account do
    name { "My account" }
    account_type { 0 }
    user
    balance { 1000.00 }
  end
end
