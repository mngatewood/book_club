class ReviewsController < ApplicationController

  def new
    # require 'pry'; binding.pry 
    @book = Book.find(params[:book])
    @review = Review.new
  end

  def create
    user_id = User.get_user_id(review_params[:username])
    review = Review.new(review_params.merge(user_id: user_id))
    if review.save
      redirect_to "/books/#{review.book_id}"
    else
      redirect_to "/reviews/new?book=#{review_params[:book_id]}"
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
