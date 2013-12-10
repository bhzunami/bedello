module ProductsHelper
	# we have to check if there are any active products
	# if we don't have any we have to print the sorry text

	def activeProduct?(product)
		range = (product.sale_start_date..product.sale_end_date)
		range.cover?(Time.now)
	end

	def isSale?(product)
		range = (product.promotionStartDate..product.promotionEndDate)
		range.cover?(Time.now)
	end

	def promotionPercent(product)
		100 -  product.promotionPrice / product.price  * 100.0

	end

	def getPrizeOfOneProduct(cart_line)
		product = cart_line[:product]
		quantity = cart_line[:quantity].to_d()
		if (product.promotionStartDate..product.promotionEndDate).cover?(Time.now)
			product.promotionPrice * quantity
		else
			product.price * quantity
		end
	end

	def getProduct(cart_line)
		cart_line[:product]
	end

	def getQuantity(cart_line)
		cart_line[:quantity]
	end

	def getTotalPrice(cart)
		total_price = cart.to_a.sum { |c| getPrizeOfOneProduct(c) }
		if total_price < 200
			total_price += 16
		end
		total_price
	end

end
