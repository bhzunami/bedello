class OrdersController < ApplicationController
before_action :set_order, only: [:show, :edit, :update, :destroy, :pending]
before_action :admin_user, only: [:index]


  def new
    @order = Order.new

  end

  def createNewOrder
    lineItems = params[:data][:lineItems]
    if not lineItems
      console.debug("LineItems: #{lineItems}")
      redirect root_path
    end
    @order = Order.new
    customer = Customer.new
    @order.customer = customer
    
    lineItems.each do |key, li|
      lineItem = LineItem.new
      lineItem.product_id = li[:product_id]
      lineItem.quantity = li[:quantity]
      @order.line_items << lineItem if LineItem
    end

    render layout: false
  end

  def create
    @order = Order.new(order_params)
    recalcProductInStore(@order, 'decrease')
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: "Order was successfully created." }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { redirect_to new_order_path, notice: "Missing Fields"}
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    recalcProductInStore(@order, 'increase')
    @order.destroy
    redirect_to root_path
    flash[:success] = "Bestellung abgebrochen"
  end

  def index
    @pending_orders = Order.with_state(:pending)
  end

  def show
    if @order.state != 'newOrder' && !admin?
      redirect_to root_path
    end
  end


# State machine
  def pending
    if @order.pending
      flash[:success] = "Bestellung erfolgreich abgeschlossen."
    else
      booking.errors.full_messages.each do |msg|
        flash[:error]= msg
      end
    end
    redirect_to root_path
  end

  private

  def set_order
      @order = Order.find(params[:id])
    end

  def order_params
    params.require(:order).permit(:ip, :payment_id, :shipment_id, line_items_attributes: [:product_id, :quantity], customer_attributes: [:formOfAddress, :firstname, :lastname, :streetname, :addressAdditive, :plz, :city, :email, :phone])
  end

  def recalcProductInStore(order, option)
    order.line_items.each do |l|
      if option == 'decrease'
        l.product.inStock -= l.quantity
      else 
        l.product.inStock += l.quantity
      end
      l.product.save
    end
  end

end
