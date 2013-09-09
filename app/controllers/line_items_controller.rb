class LineItemsController < ApplicationController

	def new

	end

	def destroy
		@line_item = LineItem.find(params[:id])
		@line_item.destroy
		redirect_to root_url
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


	def update
		@cart = current_cart
		@line_item = @cart.update_product(params[:product_id], params[:quantity])
		if @line_item.save
			flash[:success] =  "Change successfull"
			#redirect_to  @line_item.cart
			redirect_to current_cart
		end
	end
end
