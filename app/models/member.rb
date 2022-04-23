class Member < ActiveRecord::Base
    has_secure_password
    belongs_to :user
    has_many :users

    def self.from_omniauth(auth)
        where(username: auth.info.email).first_or_initialize do |user|
            user.first = auth.info.first_name
            user.last = auth.info.last_name
            user.username = auth.info.email
            user.password = SecureRandom.hex
            user.update_attribute(:referral_code, rand(36**8).to_s(36))
            user.update_attribute(:num_referred, 0)
        end
    end
end
