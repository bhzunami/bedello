class ChangeDateFormatInProducts < ActiveRecord::Migration
  def change
  	change_column :products, :sale_start_date, :date
  	change_column :products, :sale_end_date, :date
  	change_column :products, :promotionStartDate, :date
  	change_column :products, :promotionEndDate, :date
  end
end