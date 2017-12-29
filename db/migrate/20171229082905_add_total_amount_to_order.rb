class AddTotalAmountToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_amount, :decimal
  end
end
