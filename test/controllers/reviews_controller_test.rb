require "test_helper"

describe ReviewsController do
  let(:product) { products(:soap) }

  describe "reviews#index" do
    # #action
    # get reviews_path
    # #assert
    # must_respond_with :success
  end

  describe "reviews#new" do
    it "makes a new product review" do
      get new_product_review_path(product.id)
      must_respond_with :success
    end
  end

  describe "reviews#create" do

  end

end#of_ReviewsController
