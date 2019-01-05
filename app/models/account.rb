class Account < ApplicationRecord
  include TranslateEnum

  enum account_type: { standard: 0, savings: 1 }
  translate_enum :account_type

  belongs_to :user
  has_many :operations, dependent: :destroy
  has_many :template_operations, dependent: :destroy
  has_many :goals, dependent: :destroy

  monetize :balance_cents

  validates :name, presence: true

  default_scope { order(name: :asc) }

  scope :most_active, -> { where(account_type: :standard).first }
end
