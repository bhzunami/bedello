class AddPropertyIdToProducts < ActiveRecord::Migration[4.2]
  def change
    add_reference :products, :property, index: true
  end
end
