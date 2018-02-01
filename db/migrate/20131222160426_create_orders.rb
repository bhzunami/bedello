class CreateOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :ip

      t.timestamps
    end
  end
end
