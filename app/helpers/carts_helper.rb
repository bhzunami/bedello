module CartsHelper

  def current_cart
    Cart.find_by_cartSession!(session[:cart_session])
  rescue ActiveRecord::RecordNotFound
    current_cart = Cart.create
    session[:cart_session] = current_cart.cartSession
    current_cart

    # cart = Cart.create
    # session[:cartSession] = cart.cartSession
    # cart
  end

  def current_cart?(cart)
    cart == current_cart
  end
end
