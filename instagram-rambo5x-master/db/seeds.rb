# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

tom = User.create(email: "tom@myspace.com", password: "testing123")
mary = User.create(email: "mary@google.com", password: "testing123")

tom.posts.create(caption: "waiting for the next season #themandolorian", image_url: "https://imgix.bustle.com/uploads/image/2020/4/3/742c98f1-456c-4eb8-b568-221265a88892-baby-yoda.jpg")
mary.posts.create(caption: "writing rails tests", image_url: "https://i.pinimg.com/originals/8c/94/ec/8c94ec39b195062704760144d455f6b4.png")