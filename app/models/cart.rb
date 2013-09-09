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

	def add_product(product_id, quantity)
		current_item = line_items.find_by_product_id(product_id)
		if current_item
			current_item.quantity += quantity.to_f
		else
			current_item = line_items.build(product_id: product_id)
			current_item.quantity = quantity.to_f
		end
		current_item
	end

	def update_product(product_id, quantity)
		current_item = line_items.find_by_product_id(product_id)
		current_item.quantity = quantity.to_f
		current_item
	end


	def total_price
		line_items.to_a.sum { |item| item.total_price }
	end
	
	private

	def generate_cart_token
		self.cartSession = SecureRandom.urlsafe_base64
	end
end
