class ReviewsController < ApplicationController
  def index
    @reviews= Review.all
  end

  def new
    @review = Review.new
    @product = Product.find_by(id: params[:product_id])
  end

  def create
    @product = Product.find_by(id: params[:product_id])
    @review = Review.new(review_params)
    @review.product_id = @product.id
    @review.user_id = session[:user_id]
    if @review.save
      redirect_to review_path(@review.id)
    else
      render :new
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end

  def update
    @review = Review.find_by(id: params[:id])
    if session[:user_id] == @review.user_id
      # @review.product_id =
      @review.update_attributes(review_params)

      redirect_to review_path(@review.id)
    else
      flash[:status] = :failure
      flash[:error] = "Access Denied: To edit, please log in as a user."
      redirect_to root_path
    end
  end

  def destroy
    # @review = Review.find_by(id: params[:id]).destroy
    #
    # redirect_to root_path
  end

  private

  def find_review
    @review = Review.find_by_id(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :text_review)
  end
end
