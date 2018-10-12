require 'rails_helper'

describe "As a vistitor" do

  describe "When I visit a show book page" do

    it 'should show a button to delete a the book' do

      @author = Author.create(name: "Alexandre Dumas")
      @book = @author.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @user = User.create(name: "Jon Smith")
      @review = @book.reviews.create(title: "Please pass this test", rating: 5, review: "It was good.", user_id: @user.id)

      visit "/books/#{@book.id}"

      within("body") do
        expect(page).to have_content(@book.title)
      end

      click_link('Delete Book')

      within("body") do
        expect(page).to have_content("All Books")
        expect(page).to_not have_content(@book.title)
      end

    end
  end
end
