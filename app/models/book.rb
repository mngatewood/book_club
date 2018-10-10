class Book < ApplicationRecord

  validates_presence_of :title, :author, :page_count, :year_published

  has_many :reviews

end
