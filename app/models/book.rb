class Book < ApplicationRecord

  validates_presence_of :title, :page_count, :year_published

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  def average_rating
    reviews.average(:rating).to_f.round(1)
  end

  def other_authors(author_id)
    other_authors = authors.where.not(id: author_id)
    other_author_names = other_authors.map{|a|a.name}
    other_authors.count > 0 ? other_author_names : ["None"]
  end

  def top_review
    reviews.order("rating DESC").first
  end

end
