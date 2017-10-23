require "test_helper"

describe OrdersController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "OrderFulfillment Page" do
    let (:buttercup) {users(:buttercup)}

    it "shows a user's order fulfillment page " do
      get user_orders_path(buttercup.id)

      must_respond_with :success
    end

    it "only allows a user to see their order fulfillment page if they are logged in" do

    end 

    it "does not allow a user to see the order fulfillment page of a different user" do

    end

  end
end
