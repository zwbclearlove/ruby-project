class User < ApplicationRecord
  has_many :addresses
  has_many :orders
  has_many :cart_items
  has_many :comments
  has_many :messages
  has_many :favorites
  has_many :follows
end
