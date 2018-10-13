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
  @sort = params[:sort]
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

  def destroy
    @book = Book.find(params[:id])
    destroy_all_reviews_for_book(@book)
    destroy_all_bookauthors_for_book(@book)
    @book.delete
    redirect_to "/books"
  end

  def destroy_all_reviews_for_book(book)
     book.reviews.each {|r| r.delete} if book.reviews
  end

  def destroy_all_bookauthors_for_book(book)
     book.book_authors.each {|ba| ba.delete} if book.book_authors
  end

  def new
    @book = Book.new
  end

  def create    
    author_names = book_params[:author_names].split(",")
    author_ids = Author.get_ids_from_names(author_names)
    book = Book.new(book_params)
    if book.save
      BookAuthor.add_authors_to_book(book.id, author_ids)
      redirect_to "/books/#{book.id}"
    else
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author_names, :year_published, :page_count)
  end

end
