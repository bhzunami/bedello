class CartsController < ApplicationController
  
  before_action :correct_cart, only: [:show, :edit, :update, :destroy]
	before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def create
  end

	def new
	end

	def show
	end


	private

	def set_cart
		@cart = Cart.find(params[:id])
	end

	def correct_cart
		@cart = Cart.find(params[:id])
    redirect_to(root_url) unless current_cart?(@cart) or admin?
	end

end
