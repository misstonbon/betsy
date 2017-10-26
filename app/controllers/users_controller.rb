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
    if @login_user == nil || (@login_user.id != @user.id)
      render_404

    end
    @user_orders = Order.by_user(@user)
  end

end
