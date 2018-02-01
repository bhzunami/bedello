class AddRememberTokenToUsers < ActiveRecord::Migration[4.2]
  def change
    add_index :users, :remember_token
    add_index :users, :email, unique: true
  end
end
