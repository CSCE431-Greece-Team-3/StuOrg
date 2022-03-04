class User < ActiveRecord::Base
    has_secure_password 
    has_many :products, dependent: :destroy
    has_many :members
    # validates :username, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
