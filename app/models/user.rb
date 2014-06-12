class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_secure_password # too much powerful: add password & password_confirmation, ensure the existence of password and equality, and the authentication, if the column 'password_digest' exists

	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX =	/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		#preparatory stage: only with microposts posted by the current_user
		#the '?' sign needed to escape variable 'id' before inclusion into sql query, preventing sql-injection attacks	
		Micropost.where("user_id = ?", id)
	end

	private
		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end
end
