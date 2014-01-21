# == Schema Information
#
# Table name: property_items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  order       :integer
#  property_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class PropertyItem < ActiveRecord::Base
  belongs_to :property

  validates :name, presence: true
end
