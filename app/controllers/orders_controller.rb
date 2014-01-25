class OrdersController < ApplicationController
before_action :set_order, only: [:show, :edit, :update, :destroy, :pending, :accept, :reject, :archive]
before_action :admin_user, only: [:index, :archived_orders]


  def new
    @order = Order.new

  end

  def createNewOrder
    lineItems = params[:data][:lineItems]
    if not lineItems
      redirect root_path
    end
    @order = Order.new
    customer = Customer.new
    @order.customer = customer
    
    lineItems.each do |key, li|
      lineItem = LineItem.new
      lineItem.product_id = li[:product_id]
      lineItem.quantity = li[:quantity]
      if li[:property] != ""
        lineItem.propertyItem_id = li[:property]
      end

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
        format.html { redirect_to new_order_path, notice: "Bitte füllen Sie alle erfoderlichen Felder aus"}
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
    @accepted_orders = Order.with_state(:accepted)
    @rejected_orders = Order.with_state(:rejected)
  end


  def archived_orders
    @archived_orders = Order.with_state(:archived)
  end

  def show
    if @order.state != 'newOrder' && !admin?
      # Store url and go back to root_url show login please
      admin_user
    end
  end


# State machine
  def pending
    if @order.pending
      flash[:success] = "Bestellung erfolgreich abgeschlossen."
    else
      @order.errors.full_messages.each do |msg|
        flash[:error]= msg
      end
    end
    @order.sendNotifierMail()
    redirect_to root_path
  end

   def accept
    if @order.pending?
      if @order.accept
        flash[:success] = "Bestellung akzeptiert."
      else
        @order.errors.full_messages.each do |msg|
          flash[:error]= msg
        end
      end
    end
    redirect_to orders_path
  end

  def reject
    if @order.pending?
      if @order.reject
        flash[:success] = "Bestellung abgelehnt."
      else
        @order.errors.full_messages.each do |msg|
          flash[:error]= msg
        end
      end
    end
    redirect_to orders_path
  end

  def archive
    if @order.accepted? || @order.rejected?
      if @order.update_attribute(:state, "archived")
        flash[:success] = "Bestellung archiviert."
      else
        @order.errors.full_messages.each do |msg|
          flash[:error]= msg
        end
      end
    end
    redirect_to orders_path
  end

  private

  def set_order
      @order = Order.find(params[:id])
    end

  def order_params
    params.require(:order).permit(:ip, :payment_id, :shipment_id, line_items_attributes: [:product_id, :quantity, :propertyItem_id], customer_attributes: [:formOfAddress, :firstname, :lastname, :streetname, :addressAdditive, :plz, :city, :email, :phone])
  end

  def recalcProductInStore(order, option)
    order.line_items.each do |l|
      if option == 'decrease'
        l.product.inStock -= l.quantity unless l.product.inStock == 0
      else 
        l.product.inStock += l.quantity
      end
      l.product.save
    end
  end

end
