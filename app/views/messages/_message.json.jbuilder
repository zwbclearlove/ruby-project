json.extract! message, :id, :content, :create_date, :type, :from_id, :to_id, :created_at, :updated_at
json.url message_url(message, format: :json)
