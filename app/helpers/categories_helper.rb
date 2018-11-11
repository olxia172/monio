module CategoriesHelper
  def sum_of_operations_count(category)
    category.operations.count
  end

  def sum_of_operations_values(category)
    category.operations.sum(:value_cents) / 100
  end

  def sum_of_operations_values_from_last_month(category)
    category
      .operations
      .paid_in_range(Date.current.prev_month.month, Date.current.prev_month.year)
      .sum(:value_cents) / 100
  end

  def sum_of_operations_values_from_this_month(category)
    category
      .operations
      .paid_in_range(Date.current.month, Date.current.year)
      .sum(:value_cents) / 100
  end

  def value_sign(value)
    if value.positive?
      'positive'
    else
      'negative'
    end
  end
end
