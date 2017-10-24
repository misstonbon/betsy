class Order < ApplicationRecord

  STATUS = ["incomplete", "paid", "shipped"]

  # belongs_to :user
  has_many :order_items

  validates :status, presence: true, inclusion: { in: STATUS, allow_nil: false}

  def total_cost

    total = 0.0

    self.order_items.each do |item|
      product = Product.find_by_id(item.product_id)
      total += (product.price * item.quantity)
    end
    return total.round(2)
  end
end
