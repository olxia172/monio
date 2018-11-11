class AddPaidAtToOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :operations, :paid_at, :date
  end
end
