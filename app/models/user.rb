class User < ApplicationRecord
  has_many :reviews
  has_many :products

  validates :uid, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates :provider, presence: true, inclusion: { in: %w(github) }

  
end
