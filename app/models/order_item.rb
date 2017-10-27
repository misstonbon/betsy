class OrderItem < ApplicationRecord
belongs_to :product
belongs_to :order

validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}

# can we validate that quantity is less_than_or_equal_to: product.quantity?

def available?
  product = self.product

  if self.quantity > product.quantity
    return false
  else
    return true
  end
end



end
