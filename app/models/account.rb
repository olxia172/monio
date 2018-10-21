class Account < ApplicationRecord
  enum account_type: { standard: 0, savings: 1 }

  belongs_to :user
  has_many :expenses, class_name: 'Operation', foreign_key: 'source_account_id'
  has_many :incomes, class_name: 'Operation', foreign_key: 'target_account_id'

  validates :name, presence: true

  def operations
    Operation.where('operations.source_account_id = ? OR operations.target_account_id = ?', self.id, self.id)
  end
end
