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
end
