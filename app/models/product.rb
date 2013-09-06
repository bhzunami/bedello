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
#  promotionStartDate :date
#  promotionEndDate   :date
#  image              :string(255)
#  isActivate         :boolean
#  inStock            :integer
#  saleStartDate      :date
#  salesEndDate       :date
#  created_at         :datetime
#  updated_at         :datetime
#  category_id        :integer
#

class Product < ActiveRecord::Base

	belongs_to :category


	validates :title, :productNr, uniqueness: true
	validates :productNr, numericality: { greater_than_or_equal_to: 0 }
	validates :inStock, numericality: { greater_than_or_equal_to: 0 }
	validates :title, :description, :productNr, :price, :inStock, :saleStartDate, :salesEndDate, :category_id, presence: true

	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :promotionPrice, numericality: { greater_than_or_equal_to: 0.00 }, allow_nil: true

	scope :active, -> { where(isActivate: true) }
	scope :activeDate, -> { active.where("? BETWEEN saleStartDate AND salesEndDate", Date.today)}

	# range = (saleStartDate..salesEndDate)
	# range.cover?(Time.now)
end
