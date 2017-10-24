require "test_helper"

describe UsersController do

  let(:user) {users(:amy)}
  
  it "Users#Account" do

    get user_account_path(user.id)
    must_respond_with :success
  end

end
