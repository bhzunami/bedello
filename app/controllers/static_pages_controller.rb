class StaticPagesController < ApplicationController

	def home
		@categories = Category.all
	end

	def cart
	end
end
