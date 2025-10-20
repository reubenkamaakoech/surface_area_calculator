json.extract! stock_item, :id, :stock_id, :product_id, :size_id, :quantity, :created_at, :updated_at
json.url stock_item_url(stock_item, format: :json)
