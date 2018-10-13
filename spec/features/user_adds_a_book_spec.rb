require 'rails_helper'

describe "As a vistitor" do

  before(:each) do
    @author = Author.create(name: "Alexandre Dumas")
  end
  
  describe "When I visit new book page" do
    
    it 'should show a form to add a new book ' do
      
      visit "/books/new"

      within("#new-book-heading") do
        expect(page).to have_content("Add a Book")
      end
      
      within("#new_book") do
        expect(page).to have_content("Title")
        expect(page).to have_content("Author(s)")
        expect(page).to have_content("Year Published")
        expect(page).to have_content("Number of Pages")
      end
    end
  end
  
  describe 'when I enter book information into the form' do

    it 'should create a new book and redirect to the book show page' do

      visit "/books/new"

      save_and_open_page
      
      page.fill_in 'Title', with: 'Killing Road'
      page.fill_in 'Author', with: 'Dave Mustaine'
      page.fill_in 'Number of Pages', with: '176'
      page.fill_in 'Year Published', with: '2009'
      click_button("Create Book")

      within("#book-header") do
        expect(page).to have_content("Killing Road")
        expect(page).to have_content("Author(s): Dave Mustaine")
        expect(page).to have_content("Pages: 176")
        expect(page).to have_content("Year Published: 2009")
      end

      visit "/books/new"

      page.fill_in 'Title', with: 'Dragon Prince'
      page.fill_in 'Author(s)', with: 'Jane Meadows, Jill Rodgers'
      page.fill_in 'Number of Pages', with: '98'
      page.fill_in 'Year Published', with: '2015'
      click_button("Create Book")

      within("#book-header") do
        expect(page).to have_content("Dragon Prince")
        expect(page).to have_content("Author(s): Jane Meadows, Jill Rodgers")
        expect(page).to have_content("Pages: 98")
        expect(page).to have_content("Year Published: 2015")
      end

    end
  end
end
