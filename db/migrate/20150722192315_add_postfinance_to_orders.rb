class AddPostfinanceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :p_paymentMethod, :string
    add_column :orders, :p_acceptance, :string
    add_column :orders, :p_status, :integer
    add_column :orders, :p_payid, :integer
    add_column :orders, :p_brand, :string
  end
end
