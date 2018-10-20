class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.integer :name, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
