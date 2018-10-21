class Operation < ApplicationRecord
  enum operation_type: { expense: 0, income: 1, transfer: 2 }

  belongs_to :source_account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :target_account, class_name: 'Account', foreign_key: 'target_account_id', optional: true
  belongs_to :category
  belongs_to :user

  monetize :value_cents

  validate :account_assignment

  def account_assignment
    if target_account_id.present? && source_account_id == target_account_id
      errors.add(:target_account, "can't be the same as source account")
    end
  end
end
