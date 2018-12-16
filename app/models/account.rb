class Account < ApplicationRecord
  include TranslateEnum

  enum account_type: { standard: 0, savings: 1 }
  translate_enum :account_type

  belongs_to :user
  has_many :operations, dependent: :destroy
  has_many :template_operations, dependent: :destroy

  monetize :balance_cents

  validates :name, presence: true
  validate :balance_value

  scope :most_active, -> { where(account_type: :standard).first }
end
