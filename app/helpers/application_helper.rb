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
end
