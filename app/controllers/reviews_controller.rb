class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book])
    @review = Review.new
  end

  def create
    user_id = get_user_id(review_params[:username])
    review = Review.new(review_params.merge(user_id: user_id))
    if review.save
      redirect_to "/books/#{review.book_id}"
    else
      render :new
    end
  end

  def get_user_id(name)
    existing_user_id = User.get_id_from_name(name)
    # if name exists in users, get the id
    if existing_user_id
      return existing_user_id
    # otherwise, create new user and get the id
    else
      new_user = User.create(name: review_params[:username])
      @user_id = new_user.id
    end

  end

  private

  def review_params
    params.require(:review).permit(:title, :username, :rating, :review, :book_id)
  end

end
