class ChangeStoreIsOpen < ActiveRecord::Migration
  def change
  	change_column :website_settings, :webstoreOpen, :date
  	add_column :website_settings, :webstoreClose, :date
  end
end
