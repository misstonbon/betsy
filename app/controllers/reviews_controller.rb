class ReviewsController < ApplicationController
  def index
    @reviews= Review.all
  end

  def create
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
    params.require(:review).permit(:rating, :text_review)
  end
end
