class AddReferenceFromExpenseToCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :expenses, index: true
  end
end
