module ApplicationHelper
  def value_sign(value)
    if value.positive?
      'positive'
    elsif value == 0
      'zero'
    else
      'negative'
    end
  end

  def sum_of_savings
    Account.where(account_type: :savings).sum(:balance_cents) / 100.00
  end
end
