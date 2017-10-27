class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find_by(id: params[:id])
    render_404 unless @order
    if @order.status == "paid"
      create_new_order
    end
  end

  def new
    unless @order = Order.new
      render_404
    end
  end

  def edit
    @order = Order.find_by(id: params[:id])
    unless @order
      render_404
    end
  end

  def update
  end

  def place_order
    @order = Order.find_by_id(session[:order_id])
    unless @order
      render_404
    end
    @order.update_attributes(order_params)
    @order.user_id = session[:user_id]

    if @order.order_items.empty?
      flash.now[:error] = "You must add items to your cart in order to checkout"
      redirect_to root_path
      return
    elsif @order.inventory_adjust
      @order.status = "paid"
      if @order.save
        session[:order_items_count] = 0
      else
        flash.now[:error] = "Error has occured!"
        render :edit
      end
    end
  end

  def user_order
    @user_order = Order.find_by_id(params[:id])
    @user = User.find_by_id(params[:user_id])
    render_404 unless @user
    unless @user.id == session[:user_id] && Order.by_user(@user).include?(@user_order)
      flash[:error] = "You are not authorized to see this page!"
      redirect_to root_path
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

  # def inventory_adjust(order)
  #
  #
  #
  #
  #
  #     quantity = item.quantity
  #     product = Product.find_by_id(item.product_id)
  #     if product
  #       if product.quantity < quantity
  #         flash[:status] = :failure
  #         flash[:message] = "Error - quantity sought exceed quantity available. Please revise your order"
  #         render :edit
  #       else
  #         product.quantity -= quantity
  #         product.save
  #       end
  #     end
  #   end
  # end


  private
  def order_params
    params.require(:order).permit(:status, :total, :customer_name, :email, :mailing_address, :zipcode, :cc_number, :cc_expiration_date, :cc_cvv)
  end
end
