require 'digest/sha1'

class OrdersController < ApplicationController
before_action :set_order, only: [:show, :edit, :update, :destroy, :order, :pay, :deliver, :complete, :archive]
before_action :admin_user, only: [:index, :archived_orders, :delete_order]

  def new
    @order = Order.new

  end

  def postfinance
    @order = Order.find(params[:order_id])
    # Are we back from postfinace? We are back when something does not work.
    # If the transaction was good we would be in the postfinance method
    # We should always have a status
    # Check if we are from postfinacne
    if !checkPostfinanceCallBack()
      flash[:error] = "Mhh diese Angaben stammen nicht von Postfinance. Aus Sicherheitsgründen wurde der Auftrag annuliert!"
      logger.error("SHASIGN is not the same!")
      @order.delete()
      redirect_to root_path
      return
    end
    # NCERROR = 0 OK Zahlung ist gut
    if(params[:NCERROR].to_i == 0)
      # Set some order parameter
      @order.ip = params[:IP]
      @order.p_status = params[:status].to_i
      @order.p_paymentMethod = params[:PM]
      @order.p_acceptance = params[:ACCEPTANCE]
      @order.p_payid = params[:PAYID].to_i
      @order.p_brand = params[:BRAND]
      @order.pay_day = Time.now
      order()
    else
      flash[:error] = "UUPS da ist etwas schief gegangen bitte versuchen Sie es nocheinmal."
      render 'show'
    end
  end

  def createNewOrder
    # Create a new Order from the lineitems
    # This site is shown instead of the new.html.erb
    # The new.html.erb is a placeholder
    # Javascripts loads this site instead of new
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
    if @order.save
      redirect_to @order
    else
      render 'createNewOrder'
    end
  end

  def destroy
    # The order can be deleted by the owner on the last page
    if @order.state != 'newOrder' && !admin?
      admin_user
    end
    @order.destroy
    if !admin?
      flash[:success] = "Bestellung abgebrochen"
      redirect_to root_path
    else
      # If a order is deleted the products must be increased
      recalcProductInStore(@order, 'increase')
      flash[:success] = "Bestellung gelöscht"
      redirect_to orders_path
    end
  end

  def index
    #@orders = Order.find(:all, conditions: ["state != archived"])
    @orders = Order.where("state != ? and state !=? and state !=?" , 'archived', 'completed', 'newOrder')
    @completed_orders = Order.where("state = ?", 'completed')

    # Delete the uncompleted orders. When a order is created but not really finished
    # This is some cleanup work
    @uncompleted = Order.with_state(:newOrder)
    @uncompleted.each do |o|
      if o.created_at < (Time.now-2.days)
        o.destroy
      end
    end
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
    # The admin has to fill in the delivery date or pay date
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
    recalcProductInStore(@order, 'decrease')
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

  def deliver
    if @order.can_deliver?
      if @order.update_attribute(:state, "delivered")
        @order.sendDeliverNotifierMail()
        flash[:success] = "Bestätigungsmail wurde erfolgreich an #{@order.customer.email} versendet"
      else
        flash[:error] = "Bestätigungsmail wurde schon versendet"
      end
    else
      flash[:error] = "Bestätigungsmail wurde schon versendet"
    end
    redirect_to orders_path
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

  def checkPostfinanceCallBack()
    # This Method takes all parameters
    # sort them and add it to a hash string
    # Checks if the SHASIGN is correct to verify
    # if answer is from postfinance
    secret_key_out = ENV['POSTFINANCE_SHA1OUTSIG']
    hash = ""
    not_hashables_attributes = ["action", "controller", "order_id", "SHASIGN"]
    params.sort_by{ |k,v| k.upcase}.each do |key, value|
      # We have to ignore the empty values! This is important
      if not_hashables_attributes.include? key or value.nil? or value == ""
        next
      end
      # The hash key is KEY=value+seceret_key_out
      hash += key.upcase+"="+value+secret_key_out
    end
    # Make a SHA1 and check if it is the same as the param SHASIGN
    (Digest::SHA1.hexdigest(hash) ).upcase == params[:SHASIGN]
  end
end
