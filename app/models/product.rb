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

	belongs_to :category
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	scope :active, -> { where(isActivate: true) }
	scope :activeDate, -> { active.where("? BETWEEN saleStartDate AND salesEndDate", Date.today)}
	default_scope order: 'title'

	validates :title, :productNr, uniqueness: true
	validates :productNr, numericality: { greater_than_or_equal_to: 0 }
	validates :inStock, numericality: { greater_than_or_equal_to: 0 }
	validates :title, :description, :productNr, :price, :inStock, :saleStartDate, :salesEndDate, :category_id, presence: true

	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :promotionPrice, numericality: { greater_than_or_equal_to: 0.00 }, allow_nil: true
	# range = (saleStartDate..salesEndDate)
	# range.cover?(Time.now)

	private

		def ensure_not_referenced_by_any_line_item
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present')
				return false
			end
		end
end
