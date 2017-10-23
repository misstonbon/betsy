require "test_helper"

describe User do

  let(:user) { users(:amy)}

  describe "relations" do
    it "has a list of reviews" do
      user.must_respond_to :reviews
      user.reviews.each do |review|
        review.must_be_kind_of Review
      end
    end

    it "has a list of products" do
      user.must_respond_to :products
      user.products.each do |product|
        product.must_be_kind_of Product
      end
    end
  end

  describe "validations" do
    it "requires a name" do
      user = User.new(provider: "github")
      user.valid?.must_equal false
      user.errors.messages.must_include :name
    end

    it "creates new user with valid name info" do
      valid_names = ["Grace H", "Ellen O", "Ada L"]

      valid_names.each do |name|
        valid_user = User.new(name: name, provider: 'github')
        valid_user.valid?.must_equal true
      end
    end

    it "rejects new user with invalid name info" do
      invalid_names = [nil, ""]

      invalid_names.each do |name|
        invalid_user = User.new(name: name, provider: 'github')
        invalid_user.valid?.must_equal false
        invalid_user.errors.messages.must_include :name
      end
    end

    it "requires a provider" do
      user = User.new(name: "Ada L")
      user.valid?.must_equal false
      user.errors.messages.must_include :provider
    end

    it "creates new user with valid provider (github) info" do
      valid_provider = ['github']

      valid_provider.each do |provider|
        valid_user = User.new(name: 'Grace H', provider: provider)
        valid_user.valid?.must_equal true
      end
    end

    it "rejects new user with invalid provider info" do
      invalid_provider = [nil, "", 'gmail', 12, -0.5, "githublogin"]

      invalid_provider.each do |provider|
        invalid_user = User.new(name: 'Grace H', provider: provider)
        invalid_user.valid?.must_equal false
        invalid_user.errors.messages.must_include :provider
      end
    end

  end

end
