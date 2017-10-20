require "test_helper"

describe Product do
  describe "relations" do
    it "has a user" do
      prod = products(:soap)
      prod.must_respond_to :user
      prod.must_be_kind_of Product
      prod.user.must_be_kind_of User
    end

    it "has a category" do
      prod = products(:tears)
      prod.must_respond_to :categories
    end
  end

  describe "validations" do
    let(:tanja) { users(:tanja) }

    it "allows valid categories" do

    end

    it "rejects not created categories" do

    end

    it "requires a name" do
      product = Product.new(category: 'food', price: 10.00, quantity: 5, user: tanja)
      product.valid?.must_equal false
      product.errors.messages.must_include :name
    end

    it "requires unique names w/in categories" do
      category = 'food'
      name = 'test name'
      product1 = Product.new(name: name, category: category, price: 10.00, quantity: 5, user: tanja)
      product1.save!

      product2 = Product.new(name: name, category: category, price: 10.00, quantity: 5, user: tanja)
      product2.valid?.must_equal false
      # product2.errors.messages.must_include :name
    end

    it "does not require a unique name if the category is different" do
      name = 'test name'
      product1 = Product.new(name: name, category: 'food', price: 10.00, quantity: 5, user: tanja)
      product1.save!

      product2 = Product.new(name: name, category: 'cosmetics', price: 10.00, quantity: 5, user: tanja)
      product2.valid?.must_equal true
    end
  end

  describe "custom model methods " do

    describe "self.by_category(category)" do
      let(:transportation) { categories(:transportation) }

      it "returns a collection of Products of the appropriate category" do
        Product.by_category(transportation).count.must_equal 1
        Product.by_category(transportation)[0].name.must_equal "Weekend Yacht"

        ###Test This commented out test

        Product.by_category("cosmetics").must_be_kind_of Enumerable

        Product.by_category("cosmetics").count.must_equal 3

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
        Product.by_category("bamboozled").count.must_equal 0
      end

    end

    describe "self.to_merchant_hash method" do


    end

  end

end
