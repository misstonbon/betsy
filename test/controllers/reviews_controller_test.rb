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
    it "makes a new review from product's show page" do
      get new_product_review_path(product.id)
      must_respond_with :success
    end
  end

  describe "reviews#create" do

    it "creates a review with valid data (must have rating and product_id)" do
      review_data = {
        review: {
          product_id: product.id,
          rating: 5
        }
      }

      start_count = Review.count

      post product_reviews_path(review_data[:review][:product_id]), params: review_data

      Review.count.must_equal start_count + 1

    end

    it "renders bad_request: review is not created without rating" do
      review_data = {
        review: {
          product_id: product.id
        }
      }

      start_count = Review.count

      post product_reviews_path(review_data[:review][:product_id]), params: review_data

      must_respond_with :bad_request
      Review.count.must_equal start_count
    end
  end

  describe "reviews#show" do

  end

  describe "reviews#edit" do

  end

  describe "reviews#update" do

  end

  describe "reviews#destroy" do

  end

end
