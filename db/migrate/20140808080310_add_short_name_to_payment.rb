class AddShortNameToPayment < ActiveRecord::Migration[4.2]
  def change
    add_column :payments, :short_name, :string
  end
end
