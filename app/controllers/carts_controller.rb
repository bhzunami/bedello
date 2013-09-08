class CartsController < ApplicationController
  
  before_action :correct_cart, only: [:show, :edit, :update, :destroy]
	before_action :set_cart, only: [:show, :update, :destroy]


	def show
	end

	def destroy
		session.delete(:cart_session)
		@cart.destroy
		redirect_to root_url, notice: "Your cart was deleted"
	end

	private

	def set_cart
		@cart = Cart.friendly.find(params[:id])
		rescue ActiveRecord::RecordNotFound
    	logger.error "Attempt to access invalid cart #{params[:id]}"
    	flash[:notice] = 'Invalid cart'
	end

	def correct_cart
		cart = set_cart
    redirect_to(root_url) unless current_cart?(cart) or admin?
	end

end
