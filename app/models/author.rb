class Author < ApplicationRecord

  before_validation do |author|
    author.name = author.name.downcase.titleize if attribute_present? 'name'
  end

  validates_presence_of :name

  has_many :book_authors
  has_many :books, through: :book_authors

  def self.get_ids_from_names(author_names)
    author_names.reduce([]) do |id_array, author_name|
      if Author.exists?(name: author_name.strip)
        id_array << Author.find_by(name: author_name.strip).id
      else
        id_array << Author.create(name: author_name.strip).id
      end
    end
  end

end
