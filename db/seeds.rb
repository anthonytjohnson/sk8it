# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'faker'

# puts "cleaning db"
# Reviews.destroy_all
Spot.destroy_all
User.destroy_all
# puts "Populating the database..."

10.times do
  file = URI.open('https://thispersondoesnotexist.com/image')
  user = User.create!(
    email: Faker::Internet.safe_email,
    password: '123123',
    username: Faker::Superhero.name
  )
  user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

file = URI.open('https://thispersondoesnotexist.com/image')
user = User.create!(
  username: "Derek",
  email: "derek@gmail.com",
  password: "123123"
)
user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')

spot = Spot.create!(
  name: "Setagaya Park Skateboard Park",
  description: "Nice place to spend time with kids",
  address: "1-5-27 Ikejiri, Setagaya City, Tokyo",
  category: "park",
  user_id: User.last.id
)
spot.photos.attach(io: File.open("app/assets/images/setagawa1.png"), filename: "setagawa1.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/setagawa2.png"), filename: "setagawa2.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/setagawa3.png"), filename: "setagawa3.png", content_type: "image/jpeg")

spot = Spot.create!(
  name: "Murasaki Park Tokyo",
  description: "Massive half pipe and numerous ramps",
  address: "19-1 Senjusekiyacho, Adachi City, Tokyo",
  category: "park",
  user_id: User.last.id
)
spot.photos.attach(io: File.open("app/assets/images/murasaki1.png"), filename: "murasaki1.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/murasaki2.png"), filename: "murasaki2.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/murasaki3.png"), filename: "murasaki3.png", content_type: "image/jpeg")

spot = Spot.create!(
  name: "Skateboard shop | instant Odaiba store",
  description: "Expert staff",
  address: "1-1-10 Aomi, Koto City, Tokyo",
  category: "shop",
  user_id: User.last.id
)
spot.photos.attach(io: File.open("app/assets/images/odiaba1.png"), filename: "odiaba1.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/odiaba2.png"), filename: "odiaba2.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/odiaba3.png"), filename: "odiaba3.png", content_type: "image/jpeg")

spot = Spot.create!(
  name: "Prime Skateboard Store",
  description: "Unique store with excellent prices",
  address: "3-22-6 Uchikanda, Chiyoda City, Tokyo",
  category: "shop",
  user_id: User.last.id
)
spot.photos.attach(io: File.open("app/assets/images/prime1.png"), filename: "prime1.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/prime2.png"), filename: "prime2.png", content_type: "image/jpeg")
spot.photos.attach(io: File.open("app/assets/images/prime3.png"), filename: "prime3.png", content_type: "image/jpeg")
