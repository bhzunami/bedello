# == Schema Information
#
# Table name: properties
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Property < ActiveRecord::Base
	has_many :propertyItems, dependent: :destroy

	validates :name, presence: true

	accepts_nested_attributes_for :propertyItems, reject_if: lambda { |a| a[:name].blank? }, allow_destroy: true
end
