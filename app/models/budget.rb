class Budget < ApplicationRecord
  has_many :budget_entries
  has_many :settings, through: :budget_entries

  def sum_of_entries
    budget_entries.sum(:value_cents)
  end
end
