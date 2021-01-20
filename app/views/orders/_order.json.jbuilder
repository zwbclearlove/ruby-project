json.extract! order, :id, :order_id, :order_status, :order_price, :order_date, :created_at, :updated_at
json.url order_url(order, format: :json)
