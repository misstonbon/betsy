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
    it "creates a review with valid data for a real category" do
      review_data = {
        review: {
          title: "test work"
        }
      }
      CATEGORIES.each do |category|
        review_data[:review][:category] = category

        start_count = Work.count

        post works_path(category), params: work_data
        must_redirect_to work_path(Work.last)

        Work.count.must_equal start_count + 1
      end
    end

  end

end#of_ReviewsController
