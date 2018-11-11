FactoryBot.define do
  factory :setting do
    sequence(:name) { |n| "Setting #{n}" }
  end
end
