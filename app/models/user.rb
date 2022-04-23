class User < ActiveRecord::Base
    has_secure_password 
    has_many :products, dependent: :destroy
    has_many :members
    # validates :username, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
    def self.from_omniauth(auth)
        where(username: auth.info.email).first_or_initialize do |user|
            user.first = auth.info.name
            user.username = auth.info.email
            user.password = SecureRandom.hex
        end
    end
end
