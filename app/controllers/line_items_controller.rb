class LineItemsController < ApplicationController

	def new

	end

	def destroy
		@line_item = LineItem.find(params[:id])
		@line_item.destroy
		redirect_to current_cart
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

	def show
		redirect_to current_cart
	end

	def update
		@cart = current_cart
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
end
