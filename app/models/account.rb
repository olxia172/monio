class Account < ApplicationRecord
  enum type: { standard: 0, savings: 1 }

  belongs_to :user
end
