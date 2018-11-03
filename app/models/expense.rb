class Expense < ApplicationRecord
  monetize :value_cents

  belongs_to :budget
  has_many :categories, dependent: :nullify
end
