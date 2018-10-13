class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  def self.add_authors_to_book(book_id, author_ids)
    author_ids.each do |author_id|
      BookAuthor.create(book_id: book_id, author_id: author_id)
    end
  end

end
