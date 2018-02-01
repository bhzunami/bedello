class CreateShipments < ActiveRecord::Migration[4.2]
  def change
    create_table :shipments do |t|
      t.string :name
      t.decimal :costs, precision: 8, scale: 2

      t.timestamps
    end
  end
end
