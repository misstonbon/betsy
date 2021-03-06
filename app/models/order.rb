class Order < ApplicationRecord

  STATUS = ["incomplete", "paid", "complete"]
  # belongs_to :user
  # belongs_to :cart
  # has_many :products
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

  def self.by_user(user)
    #same logic as order.by_merchantn
    if !User.all.include?(user)
      return []
    else

    user.order_items.map {|order_item| order_item.order }

    end

  end

  def inventory_check
    unavailable_items = []

    self.order_items.each do |item|
      if item.available?
        next
      else
        unavailable_items << item.product.name
      end
    end

    return unavailable_items
  end

  def inventory_adjust
    unavailable = self.inventory_check
    if unavailable.empty?
      self.order_items.each do |item|
        product = Product.find_by_id(item.product_id)
        product.quantity -= item.quantity
        product.save
      end
    else
      return false
    end
  end

  def self.by_status(status, orders)
    return orders.select {|ord| ord.status == status }
  end

  # def self.change_status_to_paid(order_id)
  #   order = Order.find_by_id(order_id)
  #   # when i put order.id, it complains , does rails know to look by id this way?
  #   order.status = "paid"
  #   order.save
  # end

  # def quantity_adjust
  #   #after order has been placed, cart items are subrtacted from original quantity of items
  #   self.cart_items.each do |cart_item|
  #     product = Product.find_by_id(cart_item.product_id)
  #     if cart_item.quantity <= product.quantity
  #       product.quantity -= cart_item.quantity
  #       product.save
  #     end
  #   end
  # end
end
