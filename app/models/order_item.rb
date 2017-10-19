class OrderItem < ApplicationRecord
belongs_to :products
belongs_to :orders

validates :quantity, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}

end
