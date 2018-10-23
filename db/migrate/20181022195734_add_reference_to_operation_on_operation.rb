class AddReferenceToOperationOnOperation < ActiveRecord::Migration[5.2]
  def change
    add_reference :operations, :operation, index: true
  end
end
