class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book])
    @review = Review.new
  end

  def create
    # book = Book.find(params[:book])
    review = Review.new(review_params)
    if review.save
      redirect_to "/books/#{review.book_id}"
    else
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :user_id, :rating, :review, :book_id)
  end

end
