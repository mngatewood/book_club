class BooksController < ApplicationController
  def index
    if params[:sort] == "pages-asc"
      @books = Book.order(:page_count)
    elsif params[:sort] == "pages-desc"
      @books = Book.order(page_count: :desc)
    elsif params[:sort] == "rating-asc"
      @books = Book.sort_by_average_rating
    elsif params[:sort] == "rating-desc"
      @books = Book.sort_by_average_rating.reverse
    elsif params[:sort] == "reviews-asc"
      @books = Book.sort_by_ratings_count
    elsif params[:sort] == "reviews-desc"
      @books = Book.sort_by_ratings_count.reverse
    else
      @books = Book.all
  end
  @top_three_books = Book.top_three_books
  @bottom_three_books = Book.bottom_three_books
  @top_users = User.most_active_users
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

end
