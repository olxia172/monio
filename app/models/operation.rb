class Operation < ApplicationRecord
  attr_accessor :target_account

  paginates_per 50

  enum operation_type: { expense: 0, income: 1, transfer: 2 }

  belongs_to :account
  belongs_to :category, optional: true
  belongs_to :user
  belongs_to :operation, optional: true
  has_one :reference_operation, class_name: 'Operation', foreign_key: 'operation_id', dependent: :destroy

  monetize :value_cents

  validate :transfer_type_if_target_account_present,
           :target_account_if_transfer_type

  after_validation :create_associated_operation
  after_create :set_proper_value, :update_account_balance
  before_destroy :remember_operation_value, :remember_account
  after_destroy :restore_balance

  scope :paid_in_range, -> (month, year) { where(paid_at: Time.zone.local(year, month).all_month ) }

  def transfer_type_if_target_account_present
    if target_account.present?
      errors.add(:operation_type, "should be transfer type") unless transfer?
    end
  end

  def target_account_if_transfer_type
    if transfer?
      errors.add(:target_account, "should be present") unless target_account.present?
    end
  end

  def create_associated_operation
    if transfer? && target_account.present?
      self.create_operation(account_id: target_account,
                            category: category,
                            operation_type: :income,
                            value_cents: value_cents,
                            user: user,
                            paid_at: paid_at
                          )
      self.target_account = nil
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
