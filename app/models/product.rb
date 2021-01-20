class Product < ApplicationRecord
  belongs_to :product_type
  belongs_to :shop
  has_many :favorites
  has_many :cart_items
  has_many :order_items
  has_many :comments
end
