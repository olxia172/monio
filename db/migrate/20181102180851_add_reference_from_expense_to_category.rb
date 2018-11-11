class AddReferenceFromExpenseToCategory < ActiveRecord::Migration[5.2]
  def change
    add_reference :categories, :setting, index: true
  end
end
