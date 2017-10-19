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

  def update
    @order = Order.find_by_id(params[:id])
    @order.status = order_params[:status]
    if @order.save
      redirect_to order_path
    else
      flash.now[:error] = "Error has occured!"
      render "edit"
    end
  end

  def destroy
    Order.destroy(params[:id])
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit(:status, :total)
  end
end
