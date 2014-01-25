# == Schema Information
#
# Table name: line_items
#
#  id              :integer          not null, primary key
#  product_id      :integer
#  order_id        :integer
#  quantity        :integer
#  created_at      :datetime
#  updated_at      :datetime
#  propertyItem_id :integer
#

class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  belongs_to :propertyItem

  accepts_nested_attributes_for :product
end
