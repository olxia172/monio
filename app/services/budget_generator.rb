class BudgetGenerator
  def initialize
    @budget_month = Date.current.prev_month.month
    @budget_year = Date.current.prev_month.year
  end

  def generate
    create_budget
    create_entries

    @budget
  end

  private

  def create_budget
    @budget = Budget.create(name: "Budżet na: #{Date.current.month}-#{Date.current.year}")
  end

  def create_entries
    Setting.all.each do |setting|
      template_operations_value = setting.template_operations.where.not(operation_type: :transfer).sum(:value_cents)
      other_operations_value = setting.operations.where(template_operation_id: nil).paid_in_range(@budget_month, @budget_year).sum(:value_cents)

      value = template_operations_value + other_operations_value
      @budget.budget_entries.create(setting: setting,
                                    value_cents: value)
    end
  end
end
