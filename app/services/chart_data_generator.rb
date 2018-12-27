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
      { name: 'Zaplacone', stack: 'stack1', data: planned_spendings },
      { name: 'Do zaplacenia', stack: 'stack1', data: planned_spendings }
    ]
  end

  def planned_spendings
    entries.map { |entry| [entry.setting.name, (entry.value_cents / 100).abs] }
  end

  def entries
    @entries ||= budget.budget_entries
  end

end