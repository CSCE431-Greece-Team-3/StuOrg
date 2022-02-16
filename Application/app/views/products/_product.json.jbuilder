json.extract! product, :id, :title, :created_at, :updated_at, :price
json.url product_url(product, format: :json)
