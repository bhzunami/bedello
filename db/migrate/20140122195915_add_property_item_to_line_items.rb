class AddPropertyItemToLineItems < ActiveRecord::Migration
  def change
    add_reference :line_items, :propertyItem, index: true
  end
end
