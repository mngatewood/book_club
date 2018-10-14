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

      page.fill_in 'User Name', with: 'Bob'
      page.fill_in 'Review Title', with: 'Not bad'
      page.fill_in 'Rating', with: '3'
      page.fill_in 'Review', with: 'It was just okay.'
      click_button("Create Review")

      within("header") do
        expect(page).to have_content(@book.title)
      end

      within "article.review-container:last-child" do
        expect(page).to have_content("Title: Not bad - reviewed by Bob")
        expect(page).to have_content("Rating: 3")
        expect(page).to have_content("It was just okay")
      end

    end
  end
end
