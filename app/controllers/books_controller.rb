class BooksController < ApplicationController
  def index
    if params[:sort] == "pages"
      @books = Book.order(:page_count)
    elsif params[:sort] == "rating"
      @books = Book.sort_by_average_rating
    elsif params[:sort] == "reviews"
      @books = Book.sort_by_ratings_count
    else
      @books = Book.all
  end
  @top_users = User.most_active_users
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

end
