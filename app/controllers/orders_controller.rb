class OrdersController < ApplicationController
before_action :set_order, only: [:show, :edit, :update, :destroy]


  def new

  end
  
  def createNewOrder
    lineItems = params[:data][:lineItems]
    if not lineItems
      console.debug("LineItems: #{lineItems}")
      redirect root_path
    end
    @order = Order.new
    
    lineItems.each do |key, li|
      lineItem = LineItem.new
      lineItem.product_id = li[:product_id]
      lineItem.quantity = li[:quantity]
      @order.line_items << lineItem if LineItem
    end
    render layout: false
  end

  def create

    # @order.ip = request.remote_ip
    # if @order.save
    #   render action: 'show', status: :created, location: @order
    # else
    #   redirect_to root_path
    # end

  end

  def index
    @orders = Order.all
  end


  def edit
  end

  private

  def set_order
      @order = Order.find(params[:id])
    end

  def order_params
    params.require(:order).permit(:line_items, :ip, :customer_id)
  end

end
