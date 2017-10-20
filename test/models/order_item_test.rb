require "test_helper"

describe OrderItem do

  describe 'relationships' do

  end

  describe 'validations' do
    it "must be valid" do
      oi = order_items(:orderitem1)
      oi.valid?.must_equal true
    end

    it "is invalid if incomplete" do
      oi = OrderItem.new
      oi.valid?.must_equal false
    end

    it "must have quantity" do
      oi = order_items(:orderitem2)
      oi.quantity.must_equal 1
    end

    it "quantity can be zero" do
      oi = order_items(:orderitem2)
      oi.quantity = 0
      oi.valid?.must_equal true
    end

    


  end

end
