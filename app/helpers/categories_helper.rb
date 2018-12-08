module CategoriesHelper
  def value_sign(value)
    if value.positive?
      'positive'
    else
      'negative'
    end
  end
end
