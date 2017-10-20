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
    @order = Order.new(order_params)
   if @order.id != nil && @order.save
     flash[:success] = "Order placed!"
     redirect_to orders_path
     #logic for displaying in the index.erb
   else
     flash.now[:error] = "Unable to place order"
     render "new"
   end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find_by_id(session[:order_id])
    @order.update_attributes(order_params)
    @order.user_id = session[:user_id]
    @order.status = "paid"

    if @order.save
      redirect_to place_order_path
      # TODO need to make view, controller method to send to confirmation page with all your order details instead of root_path
    else
      flash.now[:error] = "Error has occured!"
      render :edit
    end
  end

  def place_order

  end

  def destroy
    Order.destroy(params[:id])
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit(:status, :total, :customer_name, :email, :mailing_address, :zipcode, :cc_number, :cc_expiration_date, :cc_cvv)
  end
end
