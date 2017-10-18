class User < ApplicationRecord
  has_many :reviews
  validates :name, presence: true
  validates :provider, presence: true
end
