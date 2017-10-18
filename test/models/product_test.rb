require "test_helper"

describe Product do

    describe "relations" do
    it "has a user" do
      prod = products(:soap)
      prod.must_respond_to :user
      prod.must_be_kind_of Product
      prod.user.must_be_kind_of User

    end
  end

  describe "validations" do
    let(:tanja) { users(:tanja) }

    it "allows valid categories" do
      valid_categories = ['food', 'cosmetics', 'clothing']
      valid_categories.each do |category|
        product = Product.new(name: "test", category: category, price: 10.00, quantity: 5, user: tanja)
        product.valid?.must_equal true
      end
    end

    # it "rejects not created categories" do
    #   invalid_categories = ['cat', 'dog', 'phd thesis', 1337, nil]
    #   invalid_categories.each do |category|
    #     product = Product.new(name: "test", category: category)
    #     product.valid?.must_equal false
    #     product.errors.messages.must_include :category
    #   end
    # end

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


end
