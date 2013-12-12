# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  password_digest        :string(255)
#  remember_token         :string(255)
#  admin                  :boolean
#  state                  :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
	has_secure_password

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50}
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  #validates :password_confirmation, presence: true
  after_validation { self.errors.messages.delete(:password_digest) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    self.password = "H458hj!2dn"
    self.password_confirmation = "H458hj!2dn"
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  

  # Remember token
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  	def create_remember_token
  		self.remember_token = User.encrypt(User.new_remember_token)
  	end
end
