require 'rails_helper'

describe "As a vistitor" do

  describe "When I visit a show book page" do

    it 'should show a button to delete the book' do

      @author = Author.create(name: "Alexandre Dumas")
      @book = @author.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @user = User.create(name: "Jon Smith")
      @review = @book.reviews.create(title: "Please pass this test", rating: 5, review: "It was good.", user_id: @user.id)

      visit "/books/#{@book.id}"

      within("#book-header") do
        expect(page).to have_content(@book.title)
        expect(page).to have_content("Author(s): #{@author.name}")
        expect(page).to have_content("Pages: #{@book.page_count}")
        expect(page).to have_content("Year Published: #{@book.year_published}")
      end
      
      click_button('Delete Book')
      
      within("header") do
        expect(page).to have_content("All Books")
      end

      within("main") do
        expect(page).to_not have_content(@book.title)
        expect(page).to_not have_content("Author(s): #{@author.name}")
        expect(page).to_not have_content("Pages: #{@book.page_count}")
        expect(page).to_not have_content("Year Published: #{@book.year_published}")
      end

    end
  end
end
