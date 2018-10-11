require 'rails_helper'

describe Book, type: :model do

  describe 'Validations' do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:page_count)}
    it { should validate_presence_of(:year_published)}
  end

  describe 'Relationships' do
    it { should have_many(:reviews) }
    it { should have_many(:book_authors) }
    it { should have_many(:authors).through(:book_authors)}
  end

  describe 'Methods' do

    before(:each) do
      @user_1 = User.create(name: "John")
      @user_2 = User.create(name: "Jane")
      @user_3 = User.create(name: "David")
      @book_1 = Book.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @book_2 = Book.create(title: "Babe", page_count: 428, year_published: 1911)
      @book_3 = Book.create(title: "A Game of Thrones", page_count: 811, year_published: 1990)
      @book_4 = Book.create(title: "A Storm of Swords", page_count: 1025, year_published: 1992)
      @book_5 = Book.create(title: "A Clash of Kings", page_count: 1225, year_published: 1991)
      @author_1 = @book_1.authors.create(name: "Martin")
      @author_2 = @book_1.authors.create(name: "Steve")
      @author_3 = @book_3.authors.create(name: "Fred")
      @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book: @book_2)
      @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book: @book_1)
      @review_3 = @user_1.reviews.create(title: "Great story", review: "It is a great story.", rating: 3, book: @book_1)
      @review_4 = @user_2.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 3, book: @book_1)
      @review_5 = @user_2.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 3, book: @book_2)
      @review_6 = @user_2.reviews.create(title: "A hefty volume", review: "This is a hefty and imposing volume.", rating: 4, book: @book_1)
      @review_7 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 5, book: @book_2)
      @review_8 = @user_3.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 3, book: @book_2)
      @review_9 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 5, book: @book_4)
      @review_10 = @user_3.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 1, book: @book_5)
    end

    it 'can return the average rating for a book' do
      average = @book_1.average_rating
      no_reviews = @book_3.average_rating

      expect(average).to eq(3.8)
      expect(no_reviews).to eq(0)
    end

    it 'can return other_authors' do
      other_authors = @book_1.other_authors(@author_1.id)
      no_other_author = @book_3.other_authors(@author_3.id)

      expect(other_authors).to eq([@author_2.name])
      expect(no_other_author).to eq(["None"])
    end

    it 'can return the top review' do
      top_review = @book_1.top_review

      expect(top_review).to eq(@review_2)
    end

    it 'can return the top 3 reviews' do
      top_three_reviews = @book_1.top_three_reviews

      expect(top_three_reviews).to eq([@review_2,@review_6,@review_3])
    end

    it 'can return the bottom 3 reviews' do
      bottom_three_reviews = @book_1.bottom_three_reviews

      expect(bottom_three_reviews).to eq([@review_3, @review_4, @review_6])
    end

    it 'returns the 3 highest rated book titles' do
      highest_rated_titles = Book.top_three_books

      expect(highest_rated_titles).to eq ([@book_4,@book_2,@book_1])
    end
  end
end
