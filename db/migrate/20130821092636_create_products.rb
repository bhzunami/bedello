class CreateProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :productNr
      t.decimal :price, precision: 8, scale: 2
      t.decimal :promotionPrice, precision: 8, scale: 2
      t.datetime :promotionStartDate
      t.datetime :promotionEndDate
      t.boolean :isActivate, default: true
      t.integer :inStock
      t.datetime :sale_start_date
      t.datetime :sale_end_date

      t.timestamps
    end
  end
end
