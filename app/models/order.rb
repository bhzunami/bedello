# == Schema Information
#
# Table name: orders
#
#  id          :integer          not null, primary key
#  customer_id :integer
#  ip          :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Order < ActiveRecord::Base

  has_many :line_items, dependent: :destroy
end
