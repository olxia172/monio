class CreateBudgetExpenses < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_expenses do |t|
      t.references :budget, index: true
      t.references :expense, index: true

      t.timestamps
    end
  end
end
