# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

book_1 = Book.create(title: "Don't Stop Believin'", author: "Bob Ross", page_count:200, year_published: 1990)
book_2 = Book.create(title: "Never Gonna Give You Up", author: "Les Claypool", page_count:202, year_published: 1988)
