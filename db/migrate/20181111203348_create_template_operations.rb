class CreateTemplateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :template_operations do |t|
      t.monetize :value
      t.text :comment
      t.integer :operation_type, null: false, default: 0
      t.references :user
      t.references :account
      t.references :category

      t.timestamps
    end
  end
end
