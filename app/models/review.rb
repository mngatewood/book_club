class Review < ApplicationRecord

  validates_presence_of :title, :review, :rating, :user_id, :book_id

  belongs_to :user
  belongs_to :book

  def user_name
    User.find(user_id).name
  end

end