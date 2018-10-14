class Review < ApplicationRecord

  before_save do |review|
    review.title = review.title.downcase.titleize
  end

  validates_presence_of :title, :review, :rating, :user_id, :book_id

  belongs_to :user
  belongs_to :book

  attr_accessor :username

end
