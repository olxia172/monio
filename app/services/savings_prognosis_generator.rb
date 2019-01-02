class SavingsPrognosisGenerator
  def generate
    fetch_data
  end

  private

  def fetch_data
    date = Date.current
    value = sum_of_current_savings

    data = []
    data << [date, value]

    11.times do
      date += 1.month
      value += sum_of_tempalte_savings_operations

      data << [date, value]
    end

    data
  end

  def sum_of_tempalte_savings_operations
    sum = TemplateOperation.where(operation_type: :transfer).sum(:value_cents)
    @sum_of_tempalte_savings_operations ||= sum / 100.00
  end

  def sum_of_current_savings
    sum = Account.where(account_type: :savings).sum(:balance_cents)
    @sum_of_current_savings ||=  sum / 100.00
  end
end