module GoalsHelper
  def set_class(goal)
    value = goal.percentage_paid

    if value == 100
      'bg-success'
    elsif value > 75
      'bg-info'
    elsif value > 50
      ''
    elsif value > 25
      'bg-warning'
    else
      'bg-danger'
    end

  end
end