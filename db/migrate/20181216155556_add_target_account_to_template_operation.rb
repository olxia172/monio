class AddTargetAccountToTemplateOperation < ActiveRecord::Migration[5.2]
  def change
  	add_column :template_operations, :target_account_id, :bigint, foreign_key: true, index: true
  	add_column :operations, :target_account_id, :bigint, foreign_key: true, index: true
  end
end
