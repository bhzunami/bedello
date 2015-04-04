# == Schema Information
#
# Table name: orders
#
#  id                  :integer          not null, primary key
#  customer_id         :integer
#  ip                  :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  payment_id          :integer
#  shipment_id         :integer
#  state               :string(255)
#  pay_day             :datetime
#  delivery_date       :datetime
#  distribution_number :string(255)
#  warning             :datetime
#  notes               :text
#  status              :string(255)
#

class Order < ActiveRecord::Base

  has_many :line_items, dependent: :destroy
  belongs_to :customer
  belongs_to :shipment
  belongs_to :payment 

  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :line_items

  validates :payment_id, :shipment_id, :line_items, presence: true

  default_scope order: 'created_at DESC'

  #State Machine
  state_machine :state, initial: :newOrder do
    
    event :deliver do
      transition ordered: :delivered
      transition payed: :delivered
    end

    event :pay do
      transition ordered: :payed
      transition delivered: :payed
    end

    event :complete do
      transition delivered: :completed
      transition payed: :completed
      transition ordered: :completed
    end

    event :archive do
      transition completed: :archived
    end

    event :ordered do
      transition newOrder: :ordered
    end

    state :archived do
    end

    state :ordered do
    end

    state :delivered do
    end

    state :newOrder do
    end
      
    state :completed do
    end
  end
 
  def sendNotifierMail
    OrderNotifierMailer.order_confirmation(self).deliver
    OrderNotifierMailer.order_notification(self).deliver

  end

  def sendDeliverNotifierMail
    OrderNotifierMailer.order_deliver_notification(self).deliver
  end

  def getShipPrice
    total_price = self.line_items.to_a.sum { |l| getPrice(l) }
    if total_price < 200 && self.payment.short_name != "Bar"
      total_price += 16
    end
    return total_price + self.shipment.costs + self.payment.costs
  end

  def isFlatrate?
    # isFlatrate gives false back when true! What the fuck did I done here ?!?
    # If order.payment is bar, we have a flatrate so return false
    if self.payment != nil && self.payment.short_name == "Bar"
      return true
    end
    total_price = self.line_items.to_a.sum { |l| getPrice(l) }
    # If we are under 200 we do not have a flatrate -> return ture!
    if total_price < 200
      return false
    end
    return true
  end

 def getPrice(lineItem)
    if not lineItem
      return
    end
    if (lineItem.product.promotionStartDate..lineItem.product.promotionEndDate).cover?(Time.now)
      lineItem.quantity * lineItem.product.promotionPrice
    else 
      lineItem.quantity * lineItem.product.price
    end
  end

  # When a new order in createNewOrder
  def getTotPrice()
    total_price = self.line_items.to_a.sum { |l| getPrice(l) }
    if total_price < 200
      total_price += 16
    end
    return total_price
  end

end
