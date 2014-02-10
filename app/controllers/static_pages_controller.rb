class StaticPagesController < ApplicationController

	def home
		#@webstore =  WebsiteSettings.find(1)
		#@categories = Category.all(order: "category_order")
		@products = Product.random(3) 
	end

  def about
  end

  def contact
  end

  def agb
  end

end
