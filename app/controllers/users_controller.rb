class UsersController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def account
    # @user_products = User.products
    #
    # @user_products = Products.where(:id user.id)
  end

  def order_fulfillment
    @user = User.find_by_id(params[:id])
    render_404 unless @user
    # if session[:user_id] != @user.id
    #   flash[:status] = :failure
    #   flash[:message] = "Error - You do not have permission to view this page"
    #   redirect_to root_path
    # end

    @user_orders = Order.by_user(@user)
  end

end
