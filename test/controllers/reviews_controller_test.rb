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

    it "cannot create a review for an non-existing product (no product_id)" do

    end
  end

  describe "reviews#show" do

    it "successfully shows a review page (using review_id)" do
      get review_path(Review.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus review_id" do
      bogus_review_id = Review.last.id + 1
      get review_path(bogus_review_id)
      must_respond_with :not_found
    end
  end

  describe "reviews#edit" do

    it "successfully loads edit review page" do
      get edit_review_path(Review.first)
      must_respond_with :success
    end

    it "renders 404 not_found for a bogus review_id" do
      bogus_review_id = Review.last.id + 1
      get edit_review_path(bogus_review_id)
      must_respond_with :not_found
    end

  end

  describe "reviews#update" do

  end

  describe "reviews#destroy" do

  end

end
