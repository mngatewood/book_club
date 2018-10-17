require 'rails_helper'

describe User, type: :model do

  describe 'Validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Relationships' do
    it { should have_many(:reviews) }
  end

  describe 'Methods' do

    before(:each) do

      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean

      @user_1 = User.create(name: "John")
      @user_2 = User.create(name: "Jane")
      @user_3 = User.create(name: "David")
      @user_4 = User.create(name: "Jones")
      @user_5 = User.create(name: "Lisa")
      @book_1 = Book.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @book_2 = Book.create(title: "Babe", page_count: 428, year_published: 1911)
      @book_3 = Book.create(title: "A Game of Thrones", page_count: 811, year_published: 1990)
      @book_4 = Book.create(title: "A Storm of Swords", page_count: 1025, year_published: 1992)
      @book_5 = Book.create(title: "A Clash of Kings", page_count: 1225, year_published: 1991)
      @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book: @book_2)
      @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book: @book_1)
      @review_3 = @user_5.reviews.create(title: "Great story", review: "It is a great story.", rating: 3, book: @book_1)
      @review_4 = @user_2.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 3, book: @book_1)
      @review_5 = @user_2.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 3, book: @book_2)
      @review_6 = @user_2.reviews.create(title: "A hefty volume", review: "This is a hefty and imposing volume.", rating: 4, book: @book_1)
      @review_7 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 5, book: @book_2)
      @review_8 = @user_3.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 3, book: @book_2)
      @review_9 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 5, book: @book_4)
      @review_10 = @user_4.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 1, book: @book_5)
    end

    it "should return three users with most reviews" do

      most_active_users = User.most_active_users

      expect(most_active_users).to eq([@user_2, @user_3, @user_1])

    end

    it "should return id for matching name" do

      id = User.get_id(@user_2.name)

      expect(id).to eq(@user_2.id)

    end

    it "should create a new user if name does not exist" do

      id = User.get_id("Jack")

      expect(id).to eq(6)

    end

  end
end
