class User < ApplicationRecord
  has_many :reviews
  has_many :products
  validates :name, presence: true
end
