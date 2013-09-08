# == Schema Information
#
# Table name: carts
#
#  id          :integer          not null, primary key
#  create      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  cartSession :string(255)
#

class Cart < ActiveRecord::Base
	extend FriendlyId
	friendly_id :cartSession

	has_many :line_items, dependent: :destroy

	before_create :generate_cart_token

	def add_product(product_id)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += 1
		else
			current_item = line_items.build(product_id: product_id)
		end
		current_item
	end

	private

	 def Cart.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

	def generate_cart_token
		self.cartSession = SecureRandom.urlsafe_base64
	end
end
