class AddPropertyIdToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :property, index: true
  end
end
