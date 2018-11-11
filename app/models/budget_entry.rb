class BudgetEntry < ApplicationRecord
  monetize :value_cents

  belongs_to :budget
  belongs_to :setting
end
