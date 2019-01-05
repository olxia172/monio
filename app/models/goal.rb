class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :template_operation
  has_many :operations, through: :template_operation

  monetize :final_value_cents
  monetize :paid_value_cents

  validates :name, :final_value, presence: true
end
