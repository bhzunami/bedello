class AddShortNameToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :short_name, :string
  end
end
