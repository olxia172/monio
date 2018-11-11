class Setting < ApplicationRecord
  has_many :budget_entries
  has_many :budgets, through: :budget_entries
  has_many :categories, dependent: :nullify
end
