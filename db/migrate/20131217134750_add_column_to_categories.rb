class AddColumnToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :category_order, :integer
  end
end
