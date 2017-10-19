require "test_helper"

describe ProductsController do

  describe "index" do
    it "allows you to see products when products exist" do
      Product.count.must_be :>, 0, "No products"
      get products_path
      must_respond_with :success
    end

    it "still succceeds when there are no products" do
      Product.destroy_all
      get products_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "will allow you to see a form to create a new product" do
      get new_product_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "will go to an existing product's page" do
      get product_path(Product.first.id)
      must_respond_with :success
    end

    it "will render 404 if the product does not exist" do
      nonexistant_id = ((Product.last).id) + 1

      get product_path(nonexistant_id)
      must_respond_with :not_found
    end

  end

  describe "guest" do
    it "allows guest to go to the index page" do
      get products_path

      must_respond_with :success
    end

    it "allows guest to go to a product's show page" do

    end
  end
end
