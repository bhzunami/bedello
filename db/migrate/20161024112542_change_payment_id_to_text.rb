class ChangePaymentIdToText < ActiveRecord::Migration
  def change
    change_column :orders, :p_payid, :text
  end
end
