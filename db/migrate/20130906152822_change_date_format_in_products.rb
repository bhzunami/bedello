class ChangeDateFormatInProducts < ActiveRecord::Migration
  def change
  	change_column :products, :saleStartDate, :date
  	change_column :products, :salesEndDate, :date
  	change_column :products, :promotionStartDate, :date
  	change_column :products, :promotionEndDate, :date
  end
end