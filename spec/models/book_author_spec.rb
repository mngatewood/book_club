require 'rails_helper'

describe BookAuthor, type: :model do

  describe 'Relationship' do
    it { should belong_to(:book) }
    it { should belong_to(:author) }
  end

  describe 'Methods' do

    before(:each) do
      @book = Book.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @author_1 = Author.create(name: "Martin")
      @author_2 = Author.create(name: "Steve")
    end

    it "should create book relationships for each given author" do

      BookAuthor.add_authors_to_book(@book.id, [@author_1.id, @author_2.id])

      expect(BookAuthor.count).to eq(2)
      expect(BookAuthor.first.book_id).to eq(@book.id)
      expect(BookAuthor.last.book_id).to eq(@book.id)
      expect(BookAuthor.first.author_id).to eq(@author_1.id)
      expect(BookAuthor.last.author_id).to eq(@author_2.id)

    end
    
    it "should return true if a book or author exists" do

      BookAuthor.add_authors_to_book(@book.id, [@author_1.id, @author_2.id])

      expect(BookAuthor.book_has_author?(@book.id)).to eq(true)
      expect(BookAuthor.author_has_book?(@author_1.id)).to eq(true)

    end
      
    it "should return false if a book or author does not exist" do

      expect(BookAuthor.book_has_author?(@book.id)).to eq(false)
      expect(BookAuthor.author_has_book?(@author_1.id)).to eq(false)

    end

    it "should destroy all book author relationships for a given author" do

      BookAuthor.add_authors_to_book(@book.id, [@author_1.id, @author_2.id])
      BookAuthor.destroy_all_bookauthors_for_author(@author_1)

      expect(BookAuthor.where(:author_id => @author_1.id).count).to eq(0)

    end

    it "should destroy a book if it has no authors" do

      BookAuthor.add_authors_to_book(@book.id, [@author_1.id, @author_2.id])
      books = BookAuthor.destroy_all_bookauthors_for_author(@author_1)
      BookAuthor.destroy_all_orphaned_books(books)

      expect(Book.find(@book.id)).to eq(@book)

      orphaned_books = BookAuthor.destroy_all_bookauthors_for_author(@author_2)
      BookAuthor.destroy_all_orphaned_books(orphaned_books)

      expect(BookAuthor.where(:author_id => @author_2.id).count).to eq(0)

    end

  end
end
