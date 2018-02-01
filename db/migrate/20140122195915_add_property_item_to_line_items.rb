class AddPropertyItemToLineItems < ActiveRecord::Migration[4.2]
  def change
    add_reference :line_items, :propertyItem, index: true
  end
end
