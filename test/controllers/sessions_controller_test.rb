require "test_helper"

describe SessionsController do
  it "should get login_form" do
    get sessions_login_form_url
    value(response).must_be :success?
  end

end
