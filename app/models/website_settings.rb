# == Schema Information
#
# Table name: website_settings
#
#  id           :integer          not null, primary key
#  mailAddress  :string(255)
#  webstoreOpen :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class WebsiteSettings < ActiveRecord::Base

	validates :mailAddress, uniqueness: true
	validates :mailAddress, presence: true
end
