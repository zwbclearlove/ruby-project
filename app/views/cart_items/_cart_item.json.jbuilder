json.extract! cart_item, :id, :product_name, :product_number, :created_at, :updated_at
json.url cart_item_url(cart_item, format: :json)
