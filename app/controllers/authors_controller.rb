class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def destroy
    @author = Author.find(params[:id])
    destroy_all_bookauthors_for_author(@author)
    @author.delete
    redirect_to "/books"
  end

  def destroy_all_bookauthors_for_author(author)
    author.book_authors.each {|ba| ba.delete} if author.book_authors
  end

end