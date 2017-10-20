require "test_helper"

describe ReviewsController do
  let(:product) { products(:soap) }
  let(:review) { reviews(:one) }
  let(:guest_review) { reviews(:guest_review) }

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

    it "successfuly updates existing review" do
      review_data = {
        review: {
          product_id: product.id,
          rating: 5
        }
      }

      patch review_path(review), params: review_data

      # Verify the DB was really modified
      Review.find(review.id).rating.must_equal review_data[:review][:rating]
    end

    it "does not allow non-authorized (not logged in) users to update a review" do

      review = Review.first
      review_data = {
        review: {
          product_id: product.id,
          rating: "",
          user_id: nil
        }
      }

      patch review_path(review), params: review_data
      must_redirect_to review_path(review)

      # Verify the DB was not modified
      Review.find(review.id).rating.must_equal review.rating
    end

    #HELP: SESSION OR LOGIN?
    # it "doesn't allow changes if invalid data" do
    #
    #   before_review = reviews(:two)
    #   review_data = {
    #     review: {
    #       product_id: product.id,
    #       rating: "this is bogus data"
    #     }
    #   }
    #
    #   after_review = patch review_path(before_review), params: review_data
    #   before_review.must_equal after_review
    #
    #   # Verify the DB was not modified
    #   Review.find(review.id).rating.must_equal review.rating
    # end

    it "renders 404 not_found for a bogus review_id" do
      bogus_review_id = Review.last.id + 1
      get review_path(bogus_review_id)
      must_respond_with :not_found
    end

  end

  describe "reviews#destroy" do

    it "does not allow non-authorized (not logged in) users to delete a review" do

      review_data = {
        review: {
          product_id: product.id,
          rating: 5,
          user_id: nil
        }
      }

      patch review_path(review), params: review_data
      must_redirect_to review_path(review)

      # Verify the DB was not modified
      Review.find(review.id).rating.must_equal review.rating
    end

    #HELP: SESSION OR LOGIN?
    # it "successfuly deletes a review" do
    #   review_id = Review.first.id
    #
    #   delete review_path(review_id)
    #   must_redirect_to root_path
    #
    #   # The work should really be gone
    #   Review.find_by(id: review_id).must_be_nil
    # end

    it "renders 404 not_found and does not update the DB for a bogus review_id" do
      start_count = Review.count

      bogus_review_id = Review.last.id + 1
      delete review_path(bogus_review_id)
      must_respond_with :not_found

      Review.count.must_equal start_count
    end

  end

end
