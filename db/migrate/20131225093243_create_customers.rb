class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :formOfAddress
      t.string :firstname
      t.string :lastname
      t.string :streetname
      t.string :addressAdditive
      t.integer :plz
      t.string :city
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
