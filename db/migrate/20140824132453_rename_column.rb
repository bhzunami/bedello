class RenameColumn < ActiveRecord::Migration[4.2]
  def change
  	rename_column :products, :productNr, :product_nr
  end
end
