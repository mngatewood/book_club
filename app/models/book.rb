class Book < ApplicationRecord

  validates_presence_of :title, :page_count, :year_published

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

end
