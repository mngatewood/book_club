require 'rails_helper'

describe "As a vistitor" do

  before(:each) do
    @author = Author.create(name: "Alexandre Dumas")
    @book = @author.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
  end

  describe "When I visit review new page" do

    it 'should show a form to add a new review for given book' do

      visit "/reviews/new?book=#{@book.id}"

      within("#new-review-heading") do
        expect(page).to have_content("Add a Review")
      end

      within(".new-review-container") do
        expect(page).to have_content("Book Title: #{@book.title}")
      end

      within("#new_review") do
        expect(page).to have_content("User Name")
        expect(page).to have_content("Review Title")
        expect(page).to have_content("Rating")
        expect(page).to have_content("Review")
      end
    end
  end

  describe 'when I enter review information into the form' do

    it 'should create a new review and return to the current book page' do

      visit "/reviews/new?book=#{@book.id}"

      page.fill_in 'User Name', with: 'BOB'
      page.fill_in 'Review Title', with: 'not bad'
      page.fill_in 'Rating', with: '3'
      page.fill_in 'Review', with: 'It was just okay.'
      click_button("Create Review")

      within("nav") do
        expect(page).to have_content(@book.title)
      end

      within "article.review-container:last-child" do
        expect(page).to have_content("Not Bad reviewed by Bob")
        expect(page).to have_content("Rating: 3")
        expect(page).to have_content("It was just okay")
      end

    end
  end

  describe 'if I dont enter all required fields' do

    it 'should not save and redirect to new review' do

      visit "/reviews/new?book=#{@book.id}"

      # do not fill in  user name
      page.fill_in 'Review Title', with: 'not bad'
      page.fill_in 'Rating', with: '3'
      page.fill_in 'Review', with: 'It was just okay.'
      click_button("Create Review")

      within "body" do
        expect(page).to have_content(@book.title)
        expect(page).to_not have_content("Not Bad reviewed by Bob")
        expect(page).to_not have_content("Rating: 3")
        expect(page).to_not have_content("It was just okay")
      end

    end
  end

  describe 'if I enter an invalid rating (not 1 to 5)' do

    it 'should not save and redirect to new review' do

      visit "/reviews/new?book=#{@book.id}"

      page.fill_in 'User Name', with: 'michael jones'
      page.fill_in 'Review Title', with: 'not bad'
      page.fill_in 'Rating', with: '0'
      page.fill_in 'Review', with: 'It was just okay.'
      click_button("Create Review")

      within "body" do
        expect(page).to have_content(@book.title)
        expect(page).to_not have_content("Rating: 0")
      end

      page.fill_in 'User Name', with: 'michael jones'
      page.fill_in 'Review Title', with: 'not bad'
      page.fill_in 'Rating', with: '6'
      click_button("Create Review")

      within "body" do
        expect(page).to have_content(@book.title)
        expect(page).to_not have_content("Rating: 3")
      end

    end

  end

  describe 'if a user has already submitted a review for a book' do

    it 'should not save and redirect to new review' do

      @user_1 = User.create(name: "John")
      @review_1 = @user_1.reviews.create(title: "Flirtation", review: "There are ways.", rating: 5, book: @book)

      visit "/reviews/new?book=#{@book.id}"

      page.fill_in 'User Name', with: 'John'
      page.fill_in 'Review Title', with: 'Amazing book'
      page.fill_in 'Rating', with: '4'
      page.fill_in 'Review', with: 'It was just okay.'
      click_button("Create Review")

      within "body" do
        expect(page).to have_content(@book.title)
        expect(page).to_not have_content("Amazing book")
      end

    end
  end
end
