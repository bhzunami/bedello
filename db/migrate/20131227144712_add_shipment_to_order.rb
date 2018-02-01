class AddShipmentToOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :orders, :shipment_id, :integer
  end
end
