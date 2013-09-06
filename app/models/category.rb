# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Category < ActiveRecord::Base
	has_many :products

	validates :name,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true }


end
