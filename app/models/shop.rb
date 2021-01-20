class Shop < ApplicationRecord
  belongs_to :seller
  has_many :products
  has_many :follows
  has_many :messages
end
