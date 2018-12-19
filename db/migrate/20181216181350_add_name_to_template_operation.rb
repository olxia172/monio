class AddNameToTemplateOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :template_operations, :name, :string
    add_reference :operations, :template_operation, index: true
  end
end
