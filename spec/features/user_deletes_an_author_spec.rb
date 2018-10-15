require 'rails_helper'

describe "As a vistitor" do

    before(:each) do
      @author = Author.create(name: "Alexandre Dumas")
      @book = @author.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @user = User.create(name: "Jon Smith")
      @review = @book.reviews.create(title: "Please pass this test", rating: 5, review: "It was good.", user_id: @user.id)
    end

  describe "When I visit a show author page" do

    it 'should show a delete button to delete the author' do

      visit "/authors/#{@author.id}"

      within("header") do
        expect(page).to have_content(@author.name)
      end

      within("main") do
        expect(page).to have_content(@book.title)
        expect(page).to have_content("Page Count: #{@book.page_count}")
        expect(page).to have_content("Published: #{@book.year_published}")
      end

    end
  end

  describe 'when I click the delete author button' do

    it 'should delete the author and redirect to all books page' do

      visit "/authors/#{@author.id}"

      within("header") do
        expect(page).to have_content(@author.name)
      end

      click_button('Delete Author')

      within("nav") do
        expect(page).to have_content("All Books")
      end

    end

    it 'should also delete a book if all of its authors are deleted' do

      visit "/authors/#{@author.id}"

      click_button('Delete Author')

      within("main") do
        expect(page).to_not have_content("Title: #{@book.title}")
        expect(page).to_not have_content("Page Count: #{@book.page_count}")
        expect(page).to_not have_content("Published #{@book.year_published}")
      end

    end
  end
end
