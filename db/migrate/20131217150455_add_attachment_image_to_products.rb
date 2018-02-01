class AddAttachmentImageToProducts < ActiveRecord::Migration[4.2]
  def self.up
    change_table :products do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :products, :image
  end
end
