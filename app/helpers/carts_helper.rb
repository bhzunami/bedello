module CartsHelper

  def current_cart
    Cart.find_by_cartSession!(session[:cart_session])
  rescue ActiveRecord::RecordNotFound
    current_cart = Cart.create
    session[:cart_session] = current_cart.cartSession
    current_cart
  end

  def current_cart?(cart)
    cart == current_cart
  end

  def store_product_category
    session[:product_category] = request.original_url
  end

  def go_back_to_product(default)
    redirect_to(session[:product_category] || default )
    session.delete(:product_category)
  end

  def quantity_of_carts
    quantity = 0
    current_cart.line_items.each do |line|
      quantity += line.quantity
    end
    quantity
  end

end
