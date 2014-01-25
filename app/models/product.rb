# == Schema Information
#
# Table name: products
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  description        :text
#  productNr          :string(255)
#  price              :decimal(8, 2)
#  promotionPrice     :decimal(8, 2)
#  promotionStartDate :date
#  promotionEndDate   :date
#  isActivate         :boolean          default(TRUE)
#  inStock            :integer
#  sale_start_date    :date
#  sale_end_date      :date
#  created_at         :datetime
#  updated_at         :datetime
#  category_id        :integer
#  slug               :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  property_id        :integer
#

class Product < ActiveRecord::Base

	extend FriendlyId
  friendly_id :title, use: :slugged

	belongs_to :category
	has_many :line_items
	belongs_to :property

	has_attached_file :image, styles: { medium: "300x300>", large: "700x700>", small: "100x100>" }, default_url: "/images/:style/default.jpg"


	scope :active, -> { where(isActivate: true) }
	scope :activeDate, -> { active.where("? BETWEEN sale_start_date AND sale_end_date", Date.today)}
	default_scope order: 'title'

	validates :title, :productNr, uniqueness: true
	validates :inStock, numericality: { greater_than_or_equal_to: 0 }
	validates :title, :description, :productNr, :price, :inStock, :sale_start_date, :sale_end_date, :category_id, presence: true

	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :promotionPrice, numericality: { greater_than_or_equal_to: 0.00 }, allow_nil: true

	validates_attachment_size :image, :less_than => 3.megabytes
	validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']
	# range = (sale_start_date..sale_end_date)
	# range.cover?(Time.now)


end
