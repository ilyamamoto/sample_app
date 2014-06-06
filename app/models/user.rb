class User < ActiveRecord::Base
	has_secure_password # too much powerful: add password & password_confirmation, ensure the existence of password and equality, and the authentication, if the column 'password_digest' exists
	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX =	/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
end
