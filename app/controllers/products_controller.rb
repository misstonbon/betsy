class ProductsController < ApplicationController

  def index
  end

  def show
  end

  def new
  end

  def create
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
