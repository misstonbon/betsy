class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]

  def index
    @products=  Product.all
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    # @product = Product.new(product_params)
    # if @product.save
    #
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def find_product
    @product = Product.find_by_id(params[:id])
  end

  def product_params
    params.require(:product).permit(:category, :name, :description, :price, :quantity)
  end

end
