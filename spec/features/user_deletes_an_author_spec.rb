require 'rails_helper'

describe "As a vistitor" do

  describe "When I visit a show author page" do

    it 'should show a delete button to delete the author' do

      @author = Author.create(name: "Alexandre Dumas")
      @book = @author.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @user = User.create(name: "Jon Smith")
      @review = @book.reviews.create(title: "Please pass this test", rating: 5, review: "It was good.", user_id: @user.id)

      visit "/authors/#{@author.id}"

      within("#author-header") do
        expect(page).to have_content(@author.name)
      end

      within("main") do
        expect(page).to have_content("Title: #{@book.title}")
        expect(page).to have_content("#{@book.page_count} pages")
        expect(page).to have_content("Published in #{@book.year_published}")
      end

      click_button('Delete Author')

      within("#author-header") do
        expect(page).to have_content(@author.name)
      end

      within("main") do
        expect(page).to_not have_content("Title: #{@book.title}")
        expect(page).to_not have_content("#{@book.page_count} pages")
        expect(page).to_not have_content("Published in #{@book.year_published}")
      end

    end
  end
end
