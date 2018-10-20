class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.bigint :value, null: false
      t.text :comment
      t.integer :type, null: false, default: 0
      t.references :user, foreign_key: true
      t.bigint :source_account, foreign_key: true
      t.bigint :target_account, foreign_key: true

      t.timestamps
    end
  end
end
