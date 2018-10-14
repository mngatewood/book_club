require 'rails_helper'

describe "As a vistitor" do

  before(:each) do
    @user_1 = User.create(name: "John")
    @author_1 = Author.create(name: "Martin")
    @book_1 = @author_1.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
    @book_2 = @author_1.books.create(title: "Black Friday", page_count: 192, year_published: 2003)
    @book_3 = @author_1.books.create(title: "Choke", page_count: 352, year_published: 1996)
    @book_4 = @author_1.books.create(title: "Collected Poems", page_count: 768, year_published: 1981)
    @book_5 = @author_1.books.create(title: "Babe", page_count: 428, year_published: 1911)
    @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book: @book_1)
    @review_2 = @user_1.reviews.create(title: "Your best friend until you find out he’s a drug dealer", review: "The Great Gatsby is your neighbor.", rating: 5, book: @book_2)
    @review_3 = @user_1.reviews.create(title: "Great story", review: "It is a great story.", rating: 3, book: @book_3)
    @review_4 = @user_1.reviews.create(title: "Who says psychopaths aren’t romantic?", review: "If I saw you everyday, forever, I would remember this time.", rating: 3, book: @book_4)
    @review_5 = @user_1.reviews.create(title: "Needs an editor.", review: "David Goodis needs an editor.", rating: 3, book: @book_5)
  end

  describe "when I click sort by Newest to Oldest" do

    it 'should show all reviews sorted by created_at in descending order' do

      visit "/users/#{@user_1.id}?sort=date-desc"

      within "article.review-container:first-child" do
        expect(page).to have_content(@review_5.title)
      end

      within "article.review-container:last-child" do
        expect(page).to have_content(@review_1.title)
      end

    end

    it 'should show all reviews sorted by created_at in ascending order' do

      visit "/users/#{@user_1.id}?sort=date-asc"

      within "article.review-container:first-child" do
        expect(page).to have_content(@review_1.title)
      end

      within "article.review-container:last-child" do
        expect(page).to have_content(@review_5.title)
      end

    end
  end  
end
