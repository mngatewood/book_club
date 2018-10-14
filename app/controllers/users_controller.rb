class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @sort = params[:sort]
    if @sort == "date-desc"
      @reviews = @user.reviews.order(created_at: :desc)
    elsif @sort == "date-asc"
      @reviews = @user.reviews.order(created_at: :asc)
    else
      @reviews = @user.reviews
    end
  end

end
