# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  productNr          :integer
#  price              :decimal(8, 2)
#  promotionPrice     :decimal(8, 2)
#  promotionStartDate :date
#  promotionEndDate   :date
#  image              :string(255)
#  isActivate         :boolean          default(TRUE)
#  inStock            :integer
#  saleStartDate      :date
#  salesEndDate       :date
#  created_at         :datetime
#  updated_at         :datetime
#  category_id        :integer
#

class Product < ActiveRecord::Base

	extend FriendlyId
  friendly_id :title, use: :slugged

	belongs_to :category

	scope :active, -> { where(isActivate: true) }
	scope :activeDate, -> { active.where("? BETWEEN sale_start_date AND sale_end_date", Date.today)}
	default_scope order: 'title'

	validates :title, :productNr, uniqueness: true
	validates :productNr, numericality: { greater_than_or_equal_to: 0 }
	validates :inStock, numericality: { greater_than_or_equal_to: 0 }
	validates :title, :description, :productNr, :price, :inStock, :sale_start_date, :sale_end_date, :category_id, presence: true

	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :promotionPrice, numericality: { greater_than_or_equal_to: 0.00 }, allow_nil: true
	# range = (sale_start_date..sale_end_date)
	# range.cover?(Time.now)


end
