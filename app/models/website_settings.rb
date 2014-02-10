# == Schema Information
#
# Table name: website_settings
#
#  id            :integer          not null, primary key
#  mailAddress   :string(255)
#  webstoreOpen  :date
#  created_at    :datetime
#  updated_at    :datetime
#  webstoreClose :date
#

class WebsiteSettings < ActiveRecord::Base

	validates :mailAddress, uniqueness: true
	validates :mailAddress, :webstoreOpen, :webstoreClose, presence: true
end
