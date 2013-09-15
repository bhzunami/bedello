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

end
