require "test_helper"

describe Order do
  it "quantity in order cannot exceed quantity avaiable" do


  end

  describe "custom model methods" do
    let(:bubbles) {users(:bubbles)}
    describe "self.by_user(user)" do
      it "returns a collection of orders that belong to the user" do
        Order.by_user(bubbles).must_be_kind_of Enumerable

        Order.by_user(bubbles).first.must_be_kind_of Order

        Order.by_user(bubbles).count.must_equal

      end

    end

  end
end
