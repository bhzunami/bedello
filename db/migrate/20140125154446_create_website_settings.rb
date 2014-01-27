class CreateWebsiteSettings < ActiveRecord::Migration
  def change
    create_table :website_settings do |t|
      t.string :mailAddress
      t.boolean :webstoreOpen

      t.timestamps
    end
  end
end
