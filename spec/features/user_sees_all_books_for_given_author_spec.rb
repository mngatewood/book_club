require 'rails_helper'

describe "As a vistitor" do

    before(:each) do

      @user_1 = User.create(name: "John")
      @user_2 = User.create(name: "Jane")
      @user_3 = User.create(name: "David")
      @author_1 = Author.create(name: "Alexandre Dumas")
      @author_3 = Author.create(name: "Aristophanes")
      @book_1 = @author_1.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @author_2 = @book_1.authors.create(name: "Anna Sewell")
      @book_2 = @author_1.books.create(title: "Black Friday", page_count: 192, year_published: 2003)
      @book_3 = @author_3.books.create(title: "Choke", page_count: 352, year_published: 1996)
      @book_4 = @author_3.books.create(title: "Collected Poems", page_count: 768, year_published: 1981)
      @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 2, book: @book_1)
      @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book: @book_1)
      @review_3 = @user_1.reviews.create(title: "Great story", review: "It is a great story.", rating: 2, book: @book_1)
      @review_4 = @user_2.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 4, book: @book_2)
      @review_5 = @user_2.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 2, book: @book_2)
      @review_6 = @user_2.reviews.create(title: "A hefty volume", review: "This is a hefty and imposing volume.", rating: 2, book: @book_3)
      @review_7 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 2, book: @book_4)
    end

  describe "When I visit author show page" do

    it 'should see all books for the given author' do

      visit "/authors/#{@author_1.id}"

      within("#author-heading") do
        expect(page).to have_content(@author_1.name)
      end

      within("#author-books-container") do
        expect(page).to have_content("Title: #{@book_1.title}")
        expect(page).to have_content("Title: #{@book_2.title}")
        expect(page).to_not have_content("Title: #{@book_3.title}")
        expect(page).to_not have_content("Title: #{@book_4.title}")
        expect(page).to have_content("Average Rating: #{@book_1.average_rating}")
        expect(page).to have_content("Average Rating: #{@book_2.average_rating}")
        expect(page).to_not have_content("Average Rating: #{@book_3.average_rating}")
        expect(page).to_not have_content("Average Rating: #{@book_4.average_rating}")
        expect(page).to have_content("Other Authors: #{@author_2.name}")
        expect(page).to have_content("Other Authors: None")
        expect(page).to_not have_content("Other Authors: #{@author_1}")
        expect(page).to_not have_content("Other Authors: #{@author_3}")
        expect(page).to have_content("#{@book_1.page_count} pages")
        expect(page).to have_content("#{@book_2.page_count} pages")
        expect(page).to have_content("Published in #{@book_1.year_published}")
        expect(page).to have_content("Published in #{@book_2.year_published}")
        expect(page).to have_content("Review from #{@user_1.name}")
        expect(page).to have_content("Review from #{@user_2.name}")
        expect(page).to_not have_content("Review from #{@user_3.name}")
        expect(page).to have_content(@review_2.title)
        expect(page).to have_content(@review_4.title)
        expect(page).to_not have_content(@review_1.title)
        expect(page).to_not have_content(@review_3.title)
        expect(page).to have_content("Rating: #{@review_2.rating}")
        expect(page).to have_content("Rating: #{@review_4.rating}")
        expect(page).to_not have_content("Rating: #{@review_1.rating}")
        expect(page).to_not have_content("Rating: #{@review_3.rating}")
        expect(page).to have_content(@review_2.review)
        expect(page).to have_content(@review_4.review)
        expect(page).to_not have_content(@review_1.review)
        expect(page).to_not have_content(@review_3.review)
      end
    end
  end
end
