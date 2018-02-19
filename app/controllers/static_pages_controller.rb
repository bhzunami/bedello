class StaticPagesController < ApplicationController
  before_action :log_info

	def home
    # Only show products which are active
    @products = Product.where(isActivate: true).random(3)
	end

  def about
  end

  def contact
  end

  def agb
  end

  def log_info
    logger.info "#{session[:session_id]} visit '#{controller_name}.#{action_name}'"
  end

end
