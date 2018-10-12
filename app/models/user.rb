class User < ApplicationRecord

  validates_presence_of :name

  has_many :reviews

  def self.most_active_users
    select('users.*, count(reviews.id) as review_count')
    .joins(:reviews)
    .group(:id)
    .order("review_count DESC")
    .limit(3)
  end

end