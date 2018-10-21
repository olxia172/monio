class AddmoneyToOperation < ActiveRecord::Migration[5.2]
  def change
    remove_column :operations, :value
    add_monetize :operations, :value
  end
end
