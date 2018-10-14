class Review < ApplicationRecord

  before_validation do |review|
    review.title = review.title.downcase.titleize if attribute_present? 'title'
  end

  validates_presence_of :title, :review, :rating, :user_id, :book_id

  belongs_to :user
  belongs_to :book

  attr_accessor :username

end
