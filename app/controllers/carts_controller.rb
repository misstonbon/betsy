class CartsController < ApplicationController

  def show
    @cart = OrderItem.where(order_id: session[:order_id])
    @product = OrderItem.find_by_id(params[:id])
  end

end
