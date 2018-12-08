class TemplateOperation < ApplicationRecord
  enum operation_type: { expense: 0, income: 1, transfer: 2 }

  belongs_to :account
  belongs_to :category
  belongs_to :user

  validates :planned_at, presence: true

  monetize :value_cents
end
