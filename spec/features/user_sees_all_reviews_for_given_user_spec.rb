require 'rails_helper'
require 'database_cleaner'

describe "As a vistitor" do

    before(:each) do

      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      
      @user_1 = User.create(name: "John")
      @user_2 = User.create(name: "Jane")
      @user_3 = User.create(name: "David")
      @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book_id: 15)
      @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book_id: 20)
      @review_3 = @user_1.reviews.create(title: "Great story", review: "It is a great story. ", rating: 3, book_id: 21)
      @review_4 = @user_2.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 3, book_id: 7)
      @review_5 = @user_2.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 3, book_id: 2)
      @review_6 = @user_2.reviews.create(title: "A hefty volume", review: "This is a hefty and imposing volume.", rating: 4, book_id: 5)
      @review_7 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 5, book_id: 18)
      @review_8 = @user_3.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 3, book_id: 26)
    end

  describe "When I visit user show page" do

    it 'should see all reviews for the given user' do

      visit '/users/1'

      within("#user-heading") do
        expect(page).to have_content("John")
      end

      within("#user-reviews-container") do
            binding.pry
        expect(page).to have_content("Title: #{@review_1.title}")
        expect(page).to have_content("Title: #{@review_2.title}")
        expect(page).to have_content("Title: #{@review_3.title}")
        expect(page).to have_content("Rating: #{@review_1.rating}")
        expect(page).to have_content("Rating: #{@review_2.rating}")
        expect(page).to have_content("Rating: #{@review_3.rating}")
        expect(page).to have_content("Review: #{@review_1.review}")
        expect(page).to have_content("Review: #{@review_2.review}")
        expect(page).to have_content("Review: #{@review_3.review}")
      end

    end
  end
end
