class CreatePropertyItems < ActiveRecord::Migration
  def change
    create_table :property_items do |t|
      t.string :name
      t.string :description
      t.integer :order
      t.references :property, index: true

      t.timestamps
    end
  end
end
