require "test_helper"

describe User do
  describe "relations" do
    it "has a list of reviews" do
      amy = users(:amy)
      amy.must_respond_to :reviews
      amy.reviews.each do |vote|
        vote.must_be_kind_of Review
      end
    end
  end

  describe "validations" do
    it "requires a name" do
      user = User.new
      user.valid?.must_equal false
      user.errors.messages.must_include :name
    end
  end

end
