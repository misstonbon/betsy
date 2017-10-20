class ReviewsController < ApplicationController
  before_action :find_review, only: [:show, :edit]

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
      flash[:status] = :success
      flash[:result_text] = "Successfully created your review!"
      redirect_to review_path(@review.id)
    else
      flash[:status] = :failure
      flash[:result_text] = "Error: Could not create your review.}"
      flash[:messages] = @review.errors.messages
      render :new, status: :bad_request
    end
  end

  def show
  end

  def edit
  end

  def update
    @review = Review.find_by(id: params[:id])

    if session[:user_id] == @review.user_id
      if @review.update_attributes(review_params)
        flash[:result_text] = "Successfully updated your review"

        redirect_to review_path(@review.id)
      else
        flash.now[:status] = :failure
        flash.now[:error] = "Error: Your review failed to save."
        render :edit
      end
    else
      flash[:status] = :failure
      flash[:error] = "Access Denied: To edit, please log in as a user."
      redirect_to root_path
    end
  end

  def destroy
    @review = Review.find_by(id: params[:id])
    if session[:user_id] == @review.user_id
      @review = Review.find_by(id: params[:id]).destroy
      flash[:status] = :success
      flash[:result_text] = "Successfully deleted your review!"
      redirect_to root_path
    else
      flash[:status] = :failure
      flash[:error] = "Access Denied: To delete, please log in as a user."
      redirect_to root_path
    end
  end

  private

  def find_review
    @review = Review.find_by_id(params[:id])
    # @review = Review.find_by(id: params[:id])
    render_404 unless @review
  end

  def review_params
    params.require(:review).permit(:rating, :text_review)
  end
end
