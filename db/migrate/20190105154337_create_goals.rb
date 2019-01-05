class CreateGoals < ActiveRecord::Migration[5.2]
  def change
    create_table :goals do |t|
      t.string :name
      t.monetize :final_value
      t.monetize :paid_value
      t.references :users
      t.references :template_operations

      t.timestamps
    end
  end
end
