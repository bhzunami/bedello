class LineItemsController < ApplicationController
	before_action :setCorrectCart, only: [:destroy, :create, :update]

	def new

	end

	def destroy
		@line_item = LineItem.find(params[:id])
		@line_item.destroy
		
		# Show a notice 
		flash.keep[:success] = "Cart is deleted" if @cart.line_items.empty?
			
		respond_to do |format|
			format.html { redirect_to current_cart notice: "Product deleted"}
			format.js { render 'update' }
		end
	end

	def create
		product = Product.find(params[:id])
		@line_item = @cart.add_product(params[:id], params[:quantity])

		if @line_item.save
			flash[:success] =  "#{params[:quantity]} #{product.title} was successfull added to line item"
			go_back_to_product @line_item.cart
		else
			render 'new'
		end
	end

	def show
		redirect_to current_cart
	end

	def update
		@line_item = @cart.update_product(params[:product_id], params[:quantity])
		respond_to do |format|
			if @line_item.save
				format.html { redirect_to current_cart, notice: 'Changed' }
				format.js
			else
				format.html { render action: "new" }
			end
		end
	end

	private

	def setCorrectCart
		@cart = current_cart
	end
end
