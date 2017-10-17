class Product < ApplicationRecord
  has_many :reviews
  belongs_to :user

  validates :name, presence: true, uniqueness: true, allow_nil: false
  validates :category, presence: true, allow_nil: false
  validates :price, presence: true, numericality: {only_integer: true, greater_than: 0.0}
  validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
