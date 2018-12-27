class ChartDataGenerator
  attr_reader :budget

  def initialize
    @budget = Budget.last
  end

  def generate
    fetch_chart_data
  end

  private

  def fetch_chart_data
    [
      { name: 'Zaplanowane', stack: 'stack2', data: planned_spendings },
      { name: 'Zaplacone', stack: 'stack1', data: paid },
      { name: 'Do zaplacenia', stack: 'stack1', data: left_to_pay_from_templates }
    ]
  end

  def planned_spendings
    entries.map { |entry| [entry.setting.name, (entry.value_cents / 100).abs] }
  end

  def paid
    entries.map do |entry|
      operations_sum = sum_of_operations(entry)
      name = entry.setting.name

      [name, operations_sum]
    end
  end

  def left_to_pay_from_templates
    entries.map do |entry|
      not_paid_template_operations_sum = sum_of_template_operations(entry)
      name = entry.setting.name

      [name, not_paid_template_operations_sum]
    end
  end

  def entries
    @entries ||= budget.budget_entries.where.not('value_cents > 0')
  end

  def sum_of_operations(entry)
    value_cents = entry
                    .setting
                    .operations
                    .paid_in_range(Date.current.month, Date.current.year)
                    .sum(:value_cents)
    proper_value = (value_cents.abs / 100.00)
    proper_value
  end

  def sum_of_template_operations(entry)
    value_cents = entry.setting.template_operations.not_paid_this_month.sum(:value_cents)
    proper_value = (value_cents.abs / 100.00)
    proper_value
  end

end