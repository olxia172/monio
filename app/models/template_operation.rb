class TemplateOperation < ApplicationRecord
  enum operation_type: { expense: 0, income: 1, transfer: 2 }

  belongs_to :account
  belongs_to :target_account, class_name: 'Account', foreign_key: 'target_account_id', optional: true
  belongs_to :category
  belongs_to :user

  validates :planned_at, presence: true
  validate :transfer_type_if_target_account_present,
           :target_account_if_transfer_type,
           :target_account_different_than_account

  monetize :value_cents

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
  
  def target_account_different_than_account
    if transfer? && target_account == account
      errors.add(:target_account, "should be different than account")
    end
  end
end