class RenameColumn < ActiveRecord::Migration
  def change
  	rename_column :products, :productNr, :product_nr
  end
end
