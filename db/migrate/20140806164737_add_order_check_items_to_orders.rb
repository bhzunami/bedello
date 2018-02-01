class AddOrderCheckItemsToOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :pay_day, :datetime
    add_column :orders, :delivery_date, :datetime
    add_column :orders, :distribution_number, :string
    add_column :orders, :warning, :datetime
    add_column :orders, :notes, :text
    add_column :orders, :status, :string
  end
end
