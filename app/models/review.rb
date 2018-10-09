class Review < ApplicationRecord

  validates_presence_of :title, :review, :rating, :user_id

  belongs_to :user

end