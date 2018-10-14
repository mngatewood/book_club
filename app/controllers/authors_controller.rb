class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def destroy
    @author = Author.find(params[:id])
    author_books = BookAuthor.destroy_all_bookauthors_for_author(@author)
    BookAuthor.destroy_all_orphaned_books(author_books)
    @author.delete
    redirect_to "/books"
  end

end