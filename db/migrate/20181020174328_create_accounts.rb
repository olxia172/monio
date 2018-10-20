class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.integer :type, null: false, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
