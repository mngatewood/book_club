class Review < ApplicationRecord

  validates_presence_of :title, :review, :rating, :user_id, :book_id

  belongs_to :user
  belongs_to :book

  def self.most_active_users
    select('*').group(:user_id).count
  end

end
