class CartsController < ApplicationController

	def index
	end

	def products
		@cart = Array.new
		puts(params)
    lineItems = params[:lineItems]
    lineItems.each do |key, li|
      product = Product.find( li[:product_id] )
      if li[:property] == nil || li[:property] == 0 || li[:property] == ""
        cart = {product: product, quantity: li[:quantity]}
      else
        propertyItem = PropertyItem.find(li[:property])
        cart = {product: product, quantity: li[:quantity], property: propertyItem}
      end
      @cart.push(cart)
    end
    render layout: false

	end

end
