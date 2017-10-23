class User < ApplicationRecord
  has_many :reviews
  has_many :products

  has_many :order_items, through: :products
  validates :name, presence: true
  validates :provider, presence: true
end
