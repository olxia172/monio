class AddOperationsCountToCategories < ActiveRecord::Migration[5.2]
  def change
    add_column :categories, :operations_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE categories
           SET operations_count = (SELECT count(1)
                                   FROM operations
                                   WHERE operations.category_id = categories.id)
    SQL
  end
end
