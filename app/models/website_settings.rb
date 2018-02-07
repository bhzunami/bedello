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
	validate :check_close_date



	def check_close_date
		if self.webstoreClose != nil && self.webstoreClose <= self.webstoreOpen
		  errors.add(:webstoreClose, "muss später als '#{self.webstoreOpen.strftime("%d.%m.%Y")}' liegen")
		end
	end
end
