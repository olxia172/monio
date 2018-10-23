class Operation < ApplicationRecord
  attr_accessor :target_account

  enum operation_type: { expense: 0, income: 1, transfer: 2 }

  belongs_to :account
  belongs_to :category
  belongs_to :user
  belongs_to :operation, optional: true
  has_one :reference_operation, class_name: 'Operation', foreign_key: 'operation_id', dependent: :destroy

  monetize :value_cents

  after_validation :create_associated_operation
  after_create :set_proper_value, :update_account_balance
  before_destroy :remember_operation_value, :remember_account
  after_destroy :restore_balance

  def create_associated_operation
    if transfer? && target_account.present?
      self.create_operation(account_id: target_account,
                            category: category,
                            operation_type: :income,
                            value_cents: value_cents,
                            user: user)
      self.expense!
    end
  end

  def set_proper_value
    if expense?
      self.update(value_cents: value_cents * -1)
    end
  end

  def update_account_balance
    account.increment!(:balance_cents, value_cents)
  end

  def remember_operation_value
    @value = value_cents * -1
  end

  def remember_account
    @account = account
  end

  def restore_balance
    @account.increment!(:balance_cents, @value)
  end
end
