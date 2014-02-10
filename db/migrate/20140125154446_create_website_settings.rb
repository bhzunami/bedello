class CreateWebsiteSettings < ActiveRecord::Migration
  def change
    create_table :website_settings do |t|
      t.string :mailAddress
      t.date :webstoreOpen
      t.date :webstoreClose

      t.timestamps
    end
  end
end
