class ChangePaymentIdToText < ActiveRecord::Migration[4.2]
  def change
    change_column :orders, :p_payid, :text
  end
end
