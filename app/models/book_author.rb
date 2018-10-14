class BookAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author

  def self.add_authors_to_book(book_id, author_ids)
    author_ids.each do |author_id|
      BookAuthor.create(book_id: book_id, author_id: author_id)
    end
  end

  def self.book_has_author?(book_id)
    BookAuthor.exists?(:book_id => book_id)
  end

  def self.author_has_book?(author_id)
    BookAuthor.exists?(:author_id => author_id)
  end

  def self.destroy_all_bookauthors_for_author(author)
    if author.book_authors
      books = []
      author.book_authors.each do |ba|
        books << Book.find(ba.book_id)
        ba.delete
      end
      return books
    end
  end

  def self.destroy_all_orphaned_books(books)
    books.each do |b|
      if !BookAuthor.exists?(:book_id => b.id)
        b.reviews.delete_all
        b.delete
      end
    end
  end

end
