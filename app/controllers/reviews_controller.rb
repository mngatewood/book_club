class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book])
    @review = Review.new
  end

  def create
    book = Book.find(params[:book_id])
    user_id = User.get_user_id(review_params[:username])
    user_exists = book.user_review_exists?(user_id)
    review = book.reviews.new(review_params.merge(user_id: user_id))
    if review.save && !user_exists
      redirect_to "/books/#{review.book_id}"
    else
      redirect_to "/reviews/new?book=#{review.book_id}"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @user = @review.user_id
    @review.delete
    redirect_to "/users/#{@review.user_id}"
  end

  private

  def review_params
    params.require(:review).permit(:title, :username, :rating, :review, :book_id)
  end

end
