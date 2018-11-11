class Expense < ApplicationRecord
  monetize :value_cents

  has_many :budget_expenses
  has_many :budgets, through: :budget_expenses
  has_many :categories, dependent: :nullify
end
