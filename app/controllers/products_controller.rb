
class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  # before_action :authenticate, except: [:index, :show]

  def index
    @products = find_instock
  end

  def show
    render_404 unless @product
  end

  def new
    @product = Product.new
  end

  def create

    categories = product_params[:categories].map do |c|
      Category.find_by(id: c)
    end.compact

    new_params = product_params.except(:categories)

    @product= Product.new new_params
    @product.user_id = session[:user_id]
    categories.each do |category|
      @product.categories << category
    end

    if @product.save
      flash[:status] = :success
      redirect_to product_path(@product.id)
    else
      flash[:status] = :failure
      flash.now[:result_text] = "Error: You must be logged in to add a product!"
      render :new
    end

  end

  def edit
    render_404 unless @product
  end

  def update
    categories = product_params[:categories].map do |c|
      Category.find_by(id: c)
    end.compact

    new_params = product_params.except(:categories)
    @product.update_attributes(new_params)
    categories.each do |category|
      @product.categories << category
    end


    if @product.save
      flash[:status] = :success
      flash[:result_text] = "Successfully updated #{@product.name}"
      redirect_to product_path(@product.id)
    else
      flash.now[:status] = :failure
      flash.now[:result_text] = "Could not update #{@product.name}"
      flash.now[:messages] = @product.errors.messages
      render :edit, status: :not_found
    end
  end

  def destroy
    @product.destroy
    flash[:status] = :success
    flash[:result_text] = "Successfully destroyed #{@product.name}"
    redirect_to root_path
  end

  def by_category

    @products_by_category = Product.to_category_hash
  end

  def by_merchant
    # @products_by_merchant = Product.to_merchant_hash
   #placeholder for now


    # @products = find_instock

    @products_by_merchant =  Product.to_merchant_hash

  end


  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :quantity, :stock, :photo, categories: [])
  end

  def find_instock
    @products = []
    Product.all.each do |prod|
      if prod.quantity > 0 && prod.stock == "In Stock"
        @products << prod
      end
    end
    return @products
  end

end
