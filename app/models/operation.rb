class Operation < ApplicationRecord
  enum type: { expense: 0, income: 1, transfer: 2 }

  belongs_to :source_account, class_name: 'Account', foreign_key: 'source_account_id'
  belongs_to :target_account, class_name: 'Account', foreign_key: 'target_account_id', optional: true
  belongs_to :category
  belongs_to :user
end
