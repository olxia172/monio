class Budget < ApplicationRecord
  has_many :budget_entries
  has_many :settings, through: :budget_entries

  def sum_of_income
    sum = budget_entries.where('value_cents >= 0').sum(:value_cents)
    sum / 100.00
  end

  def sum_of_expenses
    sum = budget_entries.where('value_cents < 0').sum(:value_cents)
    sum / 100.00
  end
end
