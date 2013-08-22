# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  productNr          :integer
#  price              :decimal(, )
#  promotionPrice     :decimal(, )
#  promotionStartDate :datetime
#  promotionEndDate   :datetime
#  image              :string(255)
#  isActivate         :boolean
#  inStock            :integer
#  saleStartDate      :datetime
#  salesEndDate       :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Product < ActiveRecord::Base


	validates :title, :productNr, uniqueness: true
	validates :productNr, numericality: { greater_than_or_equal_to: 0 }
	validates :inStock, numericality: true
	validates :title, :description, :productNr, :price, :inStock, :saleStartDate, :salesEndDate, presence: true

	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :promotionPrice, numericality: { greater_than_or_equal_to: 0.00 }


end
