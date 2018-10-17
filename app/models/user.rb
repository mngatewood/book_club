class User < ApplicationRecord

  before_validation do |user|
    user.name = user.name.downcase.titleize if attribute_present? 'name'
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

  def self.get_id(name)
    if User.all.pluck(:name).include?(name.titleize)
      user = User.find_by(name: name.titleize)
    else
      user = User.create(name: name)
    end
    return user.id
  end



end
