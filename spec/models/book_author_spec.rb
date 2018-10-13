require 'rails_helper'

describe BookAuthor, type: :model do

  describe 'Relationship' do
    it { should belong_to(:book) }
    it { should belong_to(:author) }
  end

  describe 'Methods' do

    it 'should create book relationships for each given author' do

      @book = Book.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @author_1 = Author.create(name: "Martin")
      @author_2 = Author.create(name: "Steve")

      BookAuthor.add_authors_to_book(@book.id, [@author_1.id, @author_2.id])

      expect(BookAuthor.count).to eq(2)
      expect(BookAuthor.first.book_id).to eq(@book.id)
      expect(BookAuthor.last.book_id).to eq(@book.id)
      expect(BookAuthor.first.author_id).to eq(@author_1.id)
      expect(BookAuthor.last.author_id).to eq(@author_2.id)

    end

  end

end
