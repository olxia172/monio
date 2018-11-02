class Expense < ApplicationRecord
  monetize :value_cents

  has_many :categories, dependent: :nullify
end
