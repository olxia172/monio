class Category < ApplicationRecord
  attr_reader :sum_of_operations_values,
              :sum_of_operations_values_from_last_month,
              :sum_of_operations_values_from_this_month,
              :sum_of_operations_count

  has_many :operations
  belongs_to :setting, optional: true

  validates :name, presence: true, uniqueness: true

  scope :avaliable_for_setting, -> (setting_id) { where(setting_id: nil).or(Category.where(setting_id: setting_id)) }

  def sum_of_operations_count
    operations.count
  end

  def sum_of_operations_values
    operations.sum(:value_cents) / 100
  end

  def sum_of_operations_values_from_last_month
    operations
      .paid_in_range(Date.current.prev_month.month, Date.current.prev_month.year)
      .sum(:value_cents) / 100
  end

  def sum_of_operations_values_from_this_month
    operations
      .paid_in_range(Date.current.month, Date.current.year)
      .sum(:value_cents) / 100
  end
end
