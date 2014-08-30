module ProductsHelper
	# we have to check if there are any active products
	# if we don't have any we have to print the sorry text

	def activeProduct?(product)
		range = (product.sale_start_date..product.sale_end_date)
		range.cover?(Time.now)
	end

	def isSale?(product)
		if( !product.promotionPrice.presence)
			return false
		end
		range = (product.promotionStartDate..product.promotionEndDate)
		range.cover?(Time.now)
	end

	def promotionPercent(product)
		100 - product.promotionPrice / product.price  * 100.0

	end

	# Get the prize of one product with quantity
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

	def getProperty(cart_line)
		cart_line[:property]
	end

	def getQuantity(cart_line)
		cart_line[:quantity]
	end

	# Get the price over all products in cart
	def getTotalPrice(cart)
		total_price = cart.to_a.sum { |c| getPrizeOfOneProduct(c) }
		if total_price < 200
			total_price += 16
		end
		total_price
	end

	def flatrate?(cart)
    total_price = cart.to_a.sum { |c| getPrizeOfOneProduct(c) }
    if total_price < 200
      return true
    else
      return false
    end
  end

  def getProductPrice(product)
  	if isSale?(product)
  		product.promotionPrice
  	else
  		product.price
  	end
  end

  def dropDown(product)
  	product.property.propertyItems.to_a.each_with_object({}){ |n,i| i[n.name] = n.id }
  	#product.property.propertyItems.each { |item| [item.name, item.id] }
  end
end
