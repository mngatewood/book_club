class User < ApplicationRecord

  before_save do |user|
    user.name = user.name.downcase.titleize
  end



  validates_presence_of :name

  has_many :reviews

  def self.most_active_users
    select('users.*, count(reviews.id) as review_count')
    .joins(:reviews)
    .group(:id)
    .order("review_count DESC, id ASC")
    .limit(3)
  end

  def self.name_exists?(name)
    user = User.find_by(name: name)
    user ? user.id : false
  end

  def self.get_user_id(name)
    if name_exists?(name)
      return name_exists?(name)
    else
      new_user = User.create(name: name)
      return new_user.id
    end
  end



end