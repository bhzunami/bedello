# == Schema Information
#
# Table name: categories
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  category_order :integer
#

class Category < ActiveRecord::Base
	has_many :products

	validates :name,  presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: true }
  validates :category_order, presence: true, uniqueness: true, numericality: { greater_than: 0 }


end
