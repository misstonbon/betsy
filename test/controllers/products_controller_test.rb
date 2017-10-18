require "test_helper"

describe ProductsController do

  describe "index" do
    it "succeeds when there are works" do
      Work.count.must_be :>, 0, "No works in the test fixtures"
      get works_path
      must_respond_with :success
    end

    it "succeeds when there are no works" do
      Work.destroy_all
      get works_path
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
