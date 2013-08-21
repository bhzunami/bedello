class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :productNr
      t.decimal :price, precision: 8, scale: 2
      t.decimal :promotionPrice, precision: 8, scale: 2
      t.datetime :promotionStartDate
      t.datetime :promotionEndDate
      t.string :image
      t.boolean :isActivate, default: true
      t.integer :inStock
      t.datetime :saleStartDate
      t.datetime :salesEndDate

      t.timestamps
    end
  end
end
