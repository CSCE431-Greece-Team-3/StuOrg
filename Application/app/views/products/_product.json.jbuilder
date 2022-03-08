json.extract! product, :id, :title, :created_at, :updated_at, :price, :quantity
json.url product_url(product, format: :json) 
