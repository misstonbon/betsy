class Cart < ApplicationRecord
  has_many :products
  belongs_to :user

  validates :product_quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, allow_nil: true}
end
