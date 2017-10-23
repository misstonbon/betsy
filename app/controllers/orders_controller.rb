class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    unless @order = Order.new
      render_404
    end
  end

  def create
    @order = Order.new
    @order.user_id = session[:user_id]
    @order.status = "incomplete"
    if @order.save
    end
  end

  def edit
    unless @order = Order.find_by(id: params[:id])
      render_404
    end
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

  private
  def order_params
    params.require(:order).permit(:status, :total, :customer_name, :email, :mailing_address, :zipcode, :cc_number, :cc_expiration_date, :cc_cvv)
  end
end
