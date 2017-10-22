require "test_helper"

describe OrderItemsController do

  describe "OrderItem#update" do

    it "only allows order_item updates for an order with an 'incomplete' status" do
    #Arrange

    #Action

    #Assert
    end

    it "does not allow order_item updates for an order with a 'paid' status" do
    #Arrange

    #Action

    #Assert
    end

  end

  describe "OrderItem#destroy" do
    let(:incomplete) {orders(:pending_order)}
    let(:paid) { orders(:paid_order) }

    let(:chocolate1) { order_items(:orderitem1) }
    let(:soap2) { order_items(:orderitem2) }


    it "only deletes an order_item from cart when order status is incomplete" do
      #Arrange
      chocolate1.order.status.must_equal "incomplete"
      #Action
      delete order_item_path(chocolate1.id)
      #Assert
      OrderItem.find_by(id: chocolate1.id).must_be_nil
      must_redirect_to order_path(incomplete.id)

    end

    it "cannot delete an order_item from cart when order status is paid" do
      #Arrange
      soap2.order.status.must_equal "paid"
      #Action
      delete order_item_path(soap2.id)
      #Assert
      OrderItem.find_by(id: soap2.id).must_equal soap2
      must_redirect_to order_path(paid.id)

    end

  end
end
