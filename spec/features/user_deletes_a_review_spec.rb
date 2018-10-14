require 'rails_helper'

describe "As a vistitor" do

  describe "When I visit a show user page" do

    it 'should show a delete button for each review' do

      @author = Author.create(name: "Alexandre Dumas")
      @book = @author.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
      @user = User.create(name: "Jon Smith")
      @review = @book.reviews.create(title: "Please pass this test", rating: 5, review: "It was good.", user_id: @user.id)

      visit "/users/#{@user.id}"

      within("nav") do
        expect(page).to have_content(@user.name)
      end

      within("main") do
        expect(page).to have_content("Title: #{@review.title}")
        expect(page).to have_content("Rating: #{@review.rating}")
        expect(page).to have_content(@review.review)
      end

      click_button('Delete Review')

      within("nav") do
        expect(page).to have_content(@user.name)
      end

      within("main") do
        expect(page).to_not have_content("Title: #{@review.title}")
        expect(page).to_not have_content("Rating: #{@review.rating}")
        expect(page).to_not have_content(@review.review)
      end
    end
  end
end
