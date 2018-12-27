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
      { name: 'Do zaplacenia', stack: 'stack1', data: planned_spendings }
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

  def entries
    @entries ||= budget.budget_entries
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

end