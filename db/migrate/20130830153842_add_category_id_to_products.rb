class AddCategoryIdToProducts < ActiveRecord::Migration[4.2]
  def change
    add_column :products, :category_id, :integer
  end
end
