class CreateBudgetEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_entries do |t|
      t.references :budget, index: true
      t.references :setting, index: true
      t.monetize :value

      t.timestamps
    end
  end
end
