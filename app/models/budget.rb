class Budget < ApplicationRecord
  has_many :budget_expenses
  has_many :expenses, through: :budget_expenses
end
