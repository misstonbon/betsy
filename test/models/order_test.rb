require "test_helper"

describe Order do
  let(:item1) {order_items(:orderitem1)}
  let(:order1) {orders(:pending_order)}
  let(:product) { products(:soap)}

  let(:user) { users(:je)}
  let(:order_w_tcost) {orders(:paid_order)}

  describe "relations" do
    it "has many order_items" do
      order1.must_respond_to :order_items
      order1.must_be_kind_of Order
      order1.order_items.each do |item|
        item.must_be_kind_of OrderItem
      end
    end
  end

  describe "validations" do

    it "an order requires a status" do
      order_no_status = Order.new
      order_no_status.valid?.must_equal false
      order_no_status.errors.messages.must_include :status
    end

    it "requires that the status is either incomplete or paid" do
      order1.status.must_be_kind_of String
      order1.status.must_equal "incomplete"
    end

    it "accepts valid status" do
      valid_status = ["paid", "incomplete", "shipped"]
      valid_status.each do |status|
        valid_order = Order.new(user_id: order1.user_id, status: status)
        valid_order.valid?.must_equal true
      end
    end

    it "rejects invalid status" do
      invalid_status = [1, nil, "no status", 0.5]
      invalid_status.each do |status|
        invalid_order = Order.new(user_id: order1.user_id, status: status)
        invalid_order.valid?.must_equal false
        invalid_order.errors.messages.must_include :status
      end
    end
  end

  describe "Order#total_cost" do

    it "order's total cost defaults to 0" do
      new_order = Order.create!(user_id: user.id, status: "incomplete")
      new_order.must_respond_to :total_cost
      new_order.total_cost.must_equal 0
    end

    it "calculates the correct total" do
      order_w_tcost.total_cost.must_equal 69.98
    end
  end

end
