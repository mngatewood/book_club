class Review < ApplicationRecord

  validates_presence_of :title, :review, :rating, :user_id, :book_id

  belongs_to :user
  belongs_to :book

end
