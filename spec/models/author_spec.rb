require 'rails_helper'

describe Author, type: :model do

  describe 'Validations' do
    it { should validate_presence_of(:name)}
  end

  describe 'Relationship' do
    it { should have_many(:book_authors) }
    it { should have_many(:books).through(:book_authors)}
  end

  describe 'Methods' do

    it 'should return an array of author ids given an array of author names' do
    
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean

      @author_1 = Author.create(name: "John Smith")
      @author_2 = Author.create(name: "Amy Adams")

      @author_name_1 = "John Smith"
      @author_name_2 = "James Washington"

      author_ids = Author.get_ids_from_names([@author_name_1, @author_name_2])

      expect(author_ids).to eq([@author_1.id, (@author_2.id + 1)])

    end
  end
end
