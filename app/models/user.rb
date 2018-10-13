class User < ApplicationRecord

  validates_presence_of :name

  has_many :reviews

  def self.most_active_users
    select('users.*, count(reviews.id) as review_count')
    .joins(:reviews)
    .group(:id)
    .order("review_count DESC, id ASC")
    .limit(3)
  end

  def self.get_id_from_name(name)
    user = User.find_by(name: name)
    user ? user.id : nil
  end

end