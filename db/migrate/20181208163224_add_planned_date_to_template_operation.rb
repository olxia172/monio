class AddPlannedDateToTemplateOperation < ActiveRecord::Migration[5.2]
  def change
    add_column :template_operations, :planned_at, :integer
  end
end
