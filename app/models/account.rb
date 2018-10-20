class Account < ApplicationRecord
  enum account_type: { standard: 0, savings: 1 }

  belongs_to :user
  has_many :operations

  validates :name, presence: true
end
