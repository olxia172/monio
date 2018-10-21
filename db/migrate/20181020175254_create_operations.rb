class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.bigint :value, null: false
      t.text :comment
      t.integer :operation_type, null: false, default: 0
      t.references :user, foreign_key: true
      t.references :source_account, foreign_key: { to_table: :accounts }
      t.references :target_account, foreign_key: { to_table: :accounts }
      t.references :category

      t.timestamps
    end
  end
end
