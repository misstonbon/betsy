require "test_helper"

describe Review do

  describe "relations" do
    let(:one) { reviews(:one) }

    it "has a user" do
      review = reviews(:one)
      review.must_respond_to :user
      review.must_be_kind_of Review
      review.user.must_be_kind_of User
    end
  end

  describe "validations" do
    it "requires a rating" do
      review = Review.new
      review.valid?.must_equal false
      review.errors.messages.must_include :rating
    end

    it "rates between 1 and 5" do
      
    end
  end

end
