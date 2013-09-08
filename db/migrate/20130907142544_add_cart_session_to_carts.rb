class AddCartSessionToCarts < ActiveRecord::Migration
  def change
  	add_column :carts, :cartSession, :string
  end
end
