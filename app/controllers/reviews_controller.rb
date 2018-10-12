class ReviewsController < ApplicationController

  def new
    @book = Book.find(params[:book])
  end

  def create
    binding.pry
    @review = @book.reviews.create(params)
  end

end