class StaticPagesController < ApplicationController

	def home
		#@webstore =  WebsiteSettings.find(1)
    # Only show products which are active
    @products = Product.where(isActivate: true).random(3)
	end

  def about
  end

  def contact
  end

  def agb
  end

end
