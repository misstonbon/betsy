require "test_helper"

describe OrdersController do
  let(:item1) {order_items(:orderitem1)}
  let(:item2) {order_items(:orderitem2)}
  let(:order1) {orders(:pending_order)}
  let(:order2) {orders(:paid_order)}

  describe "Order#index" do
    it "succeeds when there are Orders" do
      order1
      OrderItem.count.must_be :>, 0, "No Orders in the test fixtures"
      get orders_path
      must_respond_with :success
    end

    it "succeeds when there are no Orders" do
      Order.destroy_all
      get orders_path
      must_respond_with :success
    end
  end

  describe "Order#new" do
    it "works" do
      get new_order_path
      must_respond_with :success
    end
  end

  describe "Order#edit" do
    it "works" do
      get edit_order_path(order1.id)
      must_respond_with :success
    end

    it "renders 404 not_found for a non-existent order" do
      bogus_order_id = Order.last.id + 1
      get edit_order_path(bogus_order_id)
      must_respond_with :not_found
    end
  end

  describe "OrderItem#create" do

  end
end
