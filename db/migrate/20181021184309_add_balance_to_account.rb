class AddBalanceToAccount < ActiveRecord::Migration[5.2]
  def change
    add_monetize :accounts, :balance
  end
end
