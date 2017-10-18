class ReviewsController < ApplicationController
  def index
    @reviews= Review.all
  end

  def create
  end

  def destroy
  end

  def edit
  end

  def new
    @review = Review.new
  end

  def show

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
