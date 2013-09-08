# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  cart_id    :integer
#  quantity   :integer          default(1)
#  created_at :datetime
#  updated_at :datetime
#

class LineItem < ActiveRecord::Base

	belongs_to :product
	belongs_to :cart


	def total_price
		product.price * quantity
	end
end
