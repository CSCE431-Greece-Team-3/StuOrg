json.extract! member, :id, :username, :password_digest, :first, :referral_code, :last, :created_at, :updated_at
json.url member_url(member, format: :json) 
