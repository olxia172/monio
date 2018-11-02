class Account < ApplicationRecord
  enum account_type: { standard: 0, savings: 1 }

  belongs_to :user
  has_many :operations, dependent: :destroy

  monetize :balance_cents

  validates :name, presence: true
  validate :balance_value

  def balance_value
    if balance_cents < 0
      errors.add(:balance_cents, "you don't have enough funds on your account")
    end
  end
end
