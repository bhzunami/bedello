# == Schema Information
#
# Table name: payments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  costs      :decimal(8, 2)
#  created_at :datetime
#  updated_at :datetime
#

class Payment < ActiveRecord::Base

  has_many :orders

  validates :name, uniqueness: true
  validates :name, :costs, presence: true

  validates :costs, numericality: { greater_than_or_equal_to: 0 }
end
