FactoryBot.define do
  factory :operation do
    value { 100.00 }
    comment { "MyText" }
    operation_type { 'expense' }
    account
    category
    paid_at { Date.current }
    user
  end
end
