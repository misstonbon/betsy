require "test_helper"

describe OrderItem do

  describe 'relationships' do

  end

  describe 'validations' do
    it "must be valid" do
      oi = order_items(:orderitem1)
      oi.valid?.must_equal true
    end

  end

end
