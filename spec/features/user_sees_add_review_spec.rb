require 'rails_helper'

describe "As a vistitor" do

  describe "When I visit review new page" do

    xit 'should show a form to add a new review for given book' do

      @author = Author.create(name: "Alexandre Dumas")
      @book = @author_1.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)

      visit "/reviews/new/#{@book.id}"

      within("#new-review-heading") do
        expect(page).to have_content("Add a Review")
      end

      within("#new-review-form") do
        expect(page).to have_content("Book Title: #{@book.title}")
        expect(page).to have_content("Title")
        expect(page).to have_content("User")
        expect(page).to have_content("Rating")
        expect(page).to have_content("Review")
        expect(page).to have_content("Submit")
      end
    end
  end
end
