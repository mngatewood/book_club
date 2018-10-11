class Book < ApplicationRecord

  validates_presence_of :title, :page_count, :year_published

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  def average_rating
    reviews.average(:rating).round(1)
  end

  def other_authors(author_id)
    other_authors = authors.where.not(id: author_id).pluck(:name)
    other_authors.count > 0 ? other_authors : ["None"]
  end

  def top_review
    reviews.order("rating DESC").limit(1).first
  end

  def top_three_reviews
    reviews.order("rating DESC").limit(3)
  end

  def bottom_three_reviews
    reviews.order("rating ASC").limit(3)
  end

end
