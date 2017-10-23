class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
    @order.user_id = session[:user_id]
    @order.status = "incomplete"
    if @order.save

    # if @order.id != nil && @order.save
    #   flash[:success] = "Order placed!"
    #   redirect_to orders_path
    #   #logic for displaying in the index.erb
    # else
    #   flash.now[:error] = "Unable to place order"
    #   render "new"
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    # @order = Order.find_by_id(session[:order_id])
    # @order.update_attributes(order_params)
    # @order.user_id = session[:user_id]
    # @order.status = "paid"
    # @order.order_items.each do |item|
    #   quantity = item.quantity
    #   product = Product.find_by_id(item.product_id)
    #   if product
    #     if product.quanity < quantity
    #       flash[:status] = :failure
    #       flash[:message] = "Error - quantity sought exceed quantity available. Please revise your order"
    #       render :edit
    #     else
    #       product.quantity -= quantity
    #       product.save
    #     end
    #   end
    # end
    # if @order.save
    #   render :place_order
    # else
    #   flash.now[:error] = "Error has occured!"
    #   render :edit
    # end
  end

  def place_order
    @order = Order.find_by_id(session[:order_id])
    @order.update_attributes(order_params)
    @order.user_id = session[:user_id]
    @order.status = "paid"
    @order.order_items.each do |item|
      quantity = item.quantity
      product = Product.find_by_id(item.product_id)
      if product
        if product.quantity < quantity
          flash[:status] = :failure
          flash[:message] = "Error - quantity sought exceed quantity available. Please revise your order"
          render :edit
        else
          product.quantity -= quantity
          product.save
        end
      end
    end
    if @order.save
      # Reset order count
      session[:order_items_count] = 0
      render :place_order
    else
      flash.now[:error] = "Error has occured!"
      render :edit
    end


  end

  def destroy
    Order.destroy(params[:id])
    redirect_to orders_path
  end

  def order_fulfillment
    @user = User.find_by_id(params[:id])
    @user_orders = Order.by_user(@user)
  end

  private
  def order_params
    params.require(:order).permit(:status, :total, :customer_name, :email, :mailing_address, :zipcode, :cc_number, :cc_expiration_date, :cc_cvv)
  end
end
