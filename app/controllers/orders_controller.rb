class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    unless @order = Order.find_by(id: params[:id])
      render_404
    end
  end

  def new
    unless @order = Order.new
      render_404
    end
  end

  def edit
    unless @order = Order.find_by(id: params[:id])
      render_404
    end
  end

  def update
  end

  def place_order
    unless
      @order = Order.find_by_id(session[:order_id])
      render 404
    end
    @order.update_attributes(order_params)
    @order.user_id = session[:user_id]
    unless @order.order_items.count > 0
      flash.now[:error] = "You must add items to your cart in order to checkout"
      redirect_to root_path
    end
    @order.status = "paid"
    inventory_adjust(@order)
    if @order.save
      # Reset order count
      session[:order_items_count] = 0
    else
      flash.now[:error] = "Error has occured!"
      render :edit
    end
  end


  # def destroy
  #   Order.destroy(params[:id])
  #   redirect_to orders_path
  # end

  private
  def order_params
    params.require(:order).permit(:status, :total, :customer_name, :email, :mailing_address, :zipcode, :cc_number, :cc_expiration_date, :cc_cvv)
  end

  def inventory_adjust(order)
    order.order_items.each do |item|
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
  end

  def order_fulfillment
    @user = User.find_by_id(params[:id])
    render_404 unless @user
    if session[:user_id] != @user.id
      redirect_to root_path
    end 

    @user_orders = Order.all
  end

  private
  def order_params
    params.require(:order).permit(:status, :total, :customer_name, :email, :mailing_address, :zipcode, :cc_number, :cc_expiration_date, :cc_cvv)
  end
end
