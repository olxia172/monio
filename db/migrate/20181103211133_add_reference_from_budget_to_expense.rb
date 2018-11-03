class AddReferenceFromBudgetToExpense < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenses, :budget, index: true
  end
end
