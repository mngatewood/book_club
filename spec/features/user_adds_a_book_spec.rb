require 'rails_helper'

describe "As a vistitor" do

  before(:each) do
    @author_1 = Author.create(name: "Alexandre Dumas")
    @book_1 = @author_1.books.create(title: "Black Beauty", page_count: 255, year_published: 1877)
    @book_2 = @author_1.books.create(title: "Black Friday", page_count: 192, year_published: 2003)
    @book_3 = @author_1.books.create(title: "Choke", page_count: 352, year_published: 1996)
    @book_4 = @author_1.books.create(title: "Collected Poems", page_count: 768, year_published: 1981)
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
        expect(page).to have_content("Thumbnail URL")
      end
    end
  end

  describe 'when I enter book information into the form' do

    it 'should create a new book without a thumbnail and redirect to the book show page' do

      visit "/books/new"

      page.fill_in 'Title', with: 'killing road'
      page.fill_in 'Author', with: 'dave mustaine'
      page.fill_in 'Number of Pages', with: '176'
      page.fill_in 'Year Published', with: '2009'
      click_button("Create Book")

      within("nav") do
        expect(page).to have_content("Killing Road")
      end

      within("section") do
        expect(page).to have_content("Author(s): Dave Mustaine")
        expect(page).to have_content("Pages: 176")
        expect(page).to have_content("Year Published: 2009")
      end

      visit "/books/new"

      page.fill_in 'Title', with: 'DRAGON PRINCE'
      page.fill_in 'Author(s)', with: 'JANE MEADOWS, JILL RODGERS'
      page.fill_in 'Number of Pages', with: '98'
      page.fill_in 'Year Published', with: '2015'
      click_button("Create Book")

      within("nav") do
        expect(page).to have_content("Dragon Prince")
      end

      within("section") do
        expect(page).to have_content("Author(s): Jane Meadows, Jill Rodgers")
        expect(page).to have_content("Pages: 98")
        expect(page).to have_content("Year Published: 2015")
      end

    end

    it 'should create a new book with a thumbnail and redirect to the book show page' do

      visit "/books/new"

      page.fill_in 'Title', with: 'killing road'
      page.fill_in 'Author', with: 'dave mustaine'
      page.fill_in 'Number of Pages', with: '176'
      page.fill_in 'Year Published', with: '2009'
      page.fill_in 'Thumbnail URL', with: 'https://images.gr-assets.com/books/1374739885l/3711.jpg'
      click_button("Create Book")

      within("nav") do
        expect(page).to have_content("Killing Road")
      end

      within("section") do
        expect(page).to have_content("Author(s): Dave Mustaine")
        expect(page).to have_content("Pages: 176")
        expect(page).to have_content("Year Published: 2009")
        expect(page).to have_css('img', :class => 'thumbnail-img')
      end

    end


    it 'should not add a book if a book title already exists' do

      visit "/books/new"

      page.fill_in 'Title', with: 'black friday'
      page.fill_in 'Author', with: 'alexandre dumas'
      page.fill_in 'Number of Pages', with: '176'
      page.fill_in 'Year Published', with: '2009'
      click_button("Create Book")

      within("header") do
        expect(page).to have_content("Add a Book")
      end

      within("main") do
        expect(page).to_not have_content("Black Friday")
        expect(page).to_not have_content("Author(s): Alexandre Dumas")
        expect(page).to_not have_content("Pages: 255")
        expect(page).to_not have_content("Year Published: 1877")
      end

    end
  end
end
