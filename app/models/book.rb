class Book < ApplicationRecord

  before_save do |book|
    book.title = book.title.downcase.titleize
  end

  validates_presence_of :title, :page_count, :year_published

  has_many :reviews
  has_many :book_authors
  has_many :authors, through: :book_authors

  attr_accessor :author_names

  def average_rating
    reviews.count > 0 ? reviews.average(:rating).round(1) : 0
  end

  def self.sort_by_average_rating
    select('books.*, AVG(rating) AS avg_rating')
    .joins(:reviews)
    .group(:id)
    .order('avg_rating ASC')
  end

  def self.sort_by_ratings_count
    select('books.*, count(reviews.id) as review_count')
    .joins(:reviews)
    .group(:id)
    .order("review_count ASC")
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

  def self.bottom_three_books
    select('books.*, AVG(rating) AS avg_rating')
    .joins(:reviews)
    .group(:id)
    .order("avg_rating ASC")
    .limit(3)
  end

  def self.top_three_books
    select('books.*, AVG(rating) AS avg_rating')
    .joins(:reviews)
    .group(:id)
    .order("avg_rating DESC")
    .limit(3)
  end  

end
