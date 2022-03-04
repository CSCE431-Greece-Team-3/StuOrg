json.extract! member, :id, :username, :password_digest, :first, :last, :created_at, :updated_at
json.url member_url(member, format: :json) 
