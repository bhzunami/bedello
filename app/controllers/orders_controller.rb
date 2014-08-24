class OrdersController < ApplicationController
before_action :set_order, only: [:show, :edit, :update, :destroy, :delete_order, :order, :pay, :deliver, :complete, :archive]
before_action :admin_user, only: [:index, :archived_orders, :delete_order]


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
        format.html { redirect_to @order }
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

  def delete_order
    if @order.destroy
      redirect_to orders_path
      flash[:success] = "Bestellung gelöscht"
    end
  end

  def index
    #@orders = Order.find(:all, conditions: ["state != archived"])
    @orders = Order.where("state != ? and state !=?", 'archived', 'completed')
    @completed_orders = Order.where("state = ?", 'completed')

    #@orders = Order.with_state(:ordered)
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

  def update
    if @order.update(order_params)
      flash[:success] = "Bestellung erfolgreich aktualisiert"
      redirect_to orders_path
    else
      render action: 'edit'
    end
  end

# State machine
# ordered payed delivered completed archive
  def order
    if @order.update_attribute(:state, "ordered")
      flash[:success] = "Vielen Dank, Deine Bestellung wurde erfolgreich abgeschlossen."
    else
      @order.errors.full_messages.each do |msg|
        flash[:error]= msg
      end
    end
    @order.sendNotifierMail()
    redirect_to root_path
  end

  def pay
  end

  def delivere
  end

  def complete
    if @order.update_attribute(:state, "completed")
      flash[:success] = "Bestellung Abgeschlossen."
    else
      @order.errors.full_messages.each do |msg|
        flash[:error]= msg
      end
    end
    redirect_to orders_path
  end

  def archive
    if @order.can_archive?
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
    params.require(:order).permit(:ip, :payment_id, :shipment_id, :pay_day, :delivery_date, :distribution_number, :warning, :notes, :created_at, line_items_attributes: [:product_id, :quantity, :propertyItem_id], customer_attributes: [:formOfAddress, :firstname, :lastname, :streetname, :addressAdditive, :plz, :city, :email, :phone])
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
