# == Schema Information
#
# Table name: customers
#
#  id              :integer          not null, primary key
#  formOfAddress   :string(255)
#  firstname       :string(255)
#  lastname        :string(255)
#  streetname      :string(255)
#  addressAdditive :string(255)
#  plz             :integer
#  city            :string(255)
#  email           :string(255)
#  phone           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Customer < ActiveRecord::Base

  has_many :orders

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :formOfAddress, :firstname, :lastname, :streetname, :plz, :city, presence: true

end
