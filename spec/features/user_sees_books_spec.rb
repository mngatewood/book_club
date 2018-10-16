require 'rails_helper'

describe "As a vistitor" do

  before(:each) do

    @user_1 = User.create(name: "John")
    @user_2 = User.create(name: "Jane")
    @user_3 = User.create(name: "David")
    @book_1 = Book.create(title: "Black Beauty", page_count: 255, year_published: 1877)
    @book_2 = Book.create(title: "Babe", page_count: 428, year_published: 1911)
    @book_3 = Book.create(title: "A Game of Thrones", page_count: 811, year_published: 1990)
    @author_1 = @book_1.authors.create(name: "Martin")
    @author_2 = @book_2.authors.create(name: "Steve")
    @author_3 = @book_3.authors.create(name: "Fred")
    @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book: @book_2)
    @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book: @book_1)
    @review_3 = @user_1.reviews.create(title: "Great story", review: "It is a great story.", rating: 3, book: @book_1)
    @review_4 = @user_2.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 3, book: @book_1)
    @review_5 = @user_2.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 3, book: @book_2)
    @review_6 = @user_2.reviews.create(title: "A hefty volume", review: "This is a hefty and imposing volume.", rating: 4, book: @book_1)
    @review_7 = @user_3.reviews.create(title: "Must read", review: "The idea that there exists such thing as a “must read” book.", rating: 5, book: @book_3)
    @review_8 = @user_3.reviews.create(title: "Expansive", review: "White Teeth is an expansive, detailed, and beautifully written attempt.", rating: 3, book: @book_3)
  end

  describe "When I visit books index" do

    it 'should show all books' do

      visit '/books'

      within("main") do
        expect(page).to have_css("h2", :text => @book_1.title)
        expect(page).to have_css("h2", :text => @book_2.title)
        expect(page).to have_css("h2", :text => @book_3.title)
        expect(page).to have_css("li", :text => @author_1.name)
        expect(page).to have_css("li", :text => @author_2.name)
        expect(page).to have_css("li", :text => @author_3.name)
        expect(page).to have_css("li", :text => @book_1.page_count)
        expect(page).to have_css("li", :text => @book_2.page_count)
        expect(page).to have_css("li", :text => @book_3.page_count)
        expect(page).to have_css("li", :text => @book_1.year_published)
        expect(page).to have_css("li", :text => @book_2.year_published)
        expect(page).to have_css("li", :text => @book_3.year_published)
        expect(page).to have_css("li", :text => @book_1.reviews.average(:rating).round(1))
        expect(page).to have_css("li", :text => @book_2.reviews.average(:rating).round(1))
        expect(page).to have_css("li", :text => @book_3.reviews.average(:rating).round(1))
      end
    end
  end
end
