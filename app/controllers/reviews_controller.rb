class ReviewsController < ApplicationController
  def index
    @reviews= Review.all
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review.id)
    else
      # render :new
    end
  end

  def destroy
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end

  def new
    @review = Review.new
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def update
  end

  private

  def find_review
    @review = Review.find_by_id(params[:id])
  end

  def review_params
    params.require(:review).permit(:product_id, :rating, :text_review)
  end
end
