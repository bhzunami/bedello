class AddColumnToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :category_order, :integer
  end
end
