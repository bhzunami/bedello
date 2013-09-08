class LineItemsController < ApplicationController

	def new

	end

	def create
		@cart = current_cart
		product = Product.find(params[:id])
		@line_item = @cart.add_product(params[:id], params[:quantity])

		if @line_item.save
			flash[:success] =  "#{params[:quantity]} #{product.title} was successfull added to line item"
			#redirect_to  @line_item.cart
			go_back_to_product @line_item.cart
		else
			render 'new'
		end
	end
end
