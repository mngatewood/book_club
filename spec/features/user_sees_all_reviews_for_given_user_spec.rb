require 'rails_helper'

describe "As a vistitor" do

    before(:each) do
      @user_1 = User.create(name: "John")
      @user_2 = User.create(name: "Jane")
      @user_3 = User.create(name: "David")
      @book_1 = Book.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @book_2 = Book.create(title: "Black Friday", page_count: 133, year_published: 1986)
      @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book: @book_1)
      @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book: @book_1)
      @review_3 = @user_1.reviews.create(title: "Great story", review: "It is a great story.", rating: 3, book: @book_1)
      @review_4 = @user_2.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 3, book: @book_1)
      @review_5 = @user_2.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 3, book: @book_1)
      @review_6 = @user_2.reviews.create(title: "A hefty volume", review: "This is a hefty and imposing volume.", rating: 4, book: @book_1)
      @review_7 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 2, book: @book_2)
      @review_8 = @user_3.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 1, book: @book_2)
    end

  describe "When I visit user show page" do

    it 'should show all reviews for the given user' do

      visit "/users/#{@user_1.id}"

      within("header") do
        expect(page).to have_content(@user_1.name)
      end

      within("main") do
        expect(page).to have_content("Title: #{@review_1.title}")
        expect(page).to have_content("Title: #{@review_2.title}")
        expect(page).to have_content("Title: #{@review_3.title}")
        expect(page).to_not have_content("Title: #{@review_7.title}")
        expect(page).to_not have_content("Title: #{@review_8.title}")
        expect(page).to have_content("Rating: #{@review_1.rating}")
        expect(page).to have_content("Rating: #{@review_2.rating}")
        expect(page).to have_content("Rating: #{@review_3.rating}")
        expect(page).to_not have_content("Rating: #{@review_7.rating}")
        expect(page).to_not have_content("Rating: #{@review_8.rating}")
        expect(page).to have_content(@review_1.review)
        expect(page).to have_content(@review_2.review)
        expect(page).to have_content(@review_3.review)
        expect(page).to_not have_content(@review_7.review)
        expect(page).to_not have_content(@review_8.review)
      end
    end
  end
end
