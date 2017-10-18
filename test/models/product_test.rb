require "test_helper"

describe Product do

  before do
    @categories = [ "cosmetics", "food", "clothing"]
  end

  let(:product) { Product.new }

  it "must be valid" do
    value(product).must_be :valid?
  end

  describe "self.by_category(category)" do
    it "returns an array of products of the appropriate category" do
      Product.by_category("transportation").count.must_equal 1
      Product.by_category("transportation")[0].name.must_equal "Weekend Yacht"

      Product.by_category("cosmetics").count.must_equal 2

    end

    it "will not error out if there are no products of that category" do

      Product.by_category("bamboozles").count.must_equal 0
    end

  end

  describe "self.by_merchant(merchant)" do
    it "returns an array of products by the given merchant" do
      Product.by_merchant(users(:bubbles)).count.must_equal 1
      Product.by_merchant(users(:bubbles))[0].name.must_equal "Weekend Yacht"

      Product.by_merchant(users(:buttercup)).count.must_equal 2

    end

    it "will not error out if there are no products of that category" do
      Product.by_category("bamboozles").count.must_equal 0
    end

  end

end
