# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  ip          :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  payment_id  :integer
#  shipment_id :integer
#  state       :string(255)
#

class Order < ActiveRecord::Base

  has_many :line_items, dependent: :destroy
  belongs_to :customer
  belongs_to :shipment
  belongs_to :payment 

  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :line_items

  validates :payment_id, :shipment_id, :line_items, presence: true

  #State Machine
  state_machine :state, initial: :newOrder do
    
    event :accept do
      transition pending: :accepted
    end

    event :reject do
      transition pending: :rejected
    end

    event :archive do
      transition accepted: :archived
      transition rejected: :archived
    end

    event :pending do
      transition newOrder: :pending
    end

    state :archived do
    end

    state :accepted do
    end

    state :rejected do
    end

    state :pending do
    end

    state :newOrder do
    end
      
  end
 
  def sendNotifierMail
    OrderNotifierMailer.order_confirmation(self).deliver
    OrderNotifierMailer.order_notification(self).deliver
  end
end
