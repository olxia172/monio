class Setting < ApplicationRecord
  has_many :budget_entries
  has_many :budgets, through: :budget_entries
  has_many :categories, dependent: :nullify

  default_scope { order(name: :asc) }

  def operations
    Operation.where(category_id: category_ids)
  end

  def template_operations
    TemplateOperation.where(category_id: category_ids)
  end
end
