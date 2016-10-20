# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.new(name: "Nyssa Hart", gender: 1, phone: "010-0221-3836").save
User.new(name: "Madaline Hatfiel", gender: 2, phone: "010-8429-9515").save
User.new(name: "Zelda Richmond", gender: 1, phone: "010-9674-5290").save

Post.new(user_id: 1, title: "vitae purus", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna").save
Post.new(user_id: 1, title: "eros non", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec").save
Post.new(user_id: 2, title: "ut quam", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing").save
Post.new(user_id: 2, title: "elit, pellentesque", content: "Lorem ipsum dolor sit amet")
Post.new(user_id: 3, title: "aliquet odio.", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut").save
Post.new(user_id: 3, title: "Proin vel", content: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam").save



