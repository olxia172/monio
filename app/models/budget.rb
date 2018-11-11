class Budget < ApplicationRecord
  has_many :budget_entries
  has_many :settings, through: :budget_entries
end
