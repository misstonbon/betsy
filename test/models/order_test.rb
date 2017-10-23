require "test_helper"

describe Order do
  let(:item1) {order_items(:orderitem1)}
  let(:order1) {orders(:pending_order)}
  let(:product) { products(:soap)}

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
    # it "requires a status" do
    #   valid_categories = ['album', 'book', 'movie']
    #   valid_categories.each do |category|
    #     work = Work.new(title: "test", category: category)
    #     work.valid?.must_equal true
    #   end
    # end
  end
  it "quantity in order cannot exceed quantity available" do


  end
end
