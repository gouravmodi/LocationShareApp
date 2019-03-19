# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create 10 Users
1.upto(10).each do |num|
  User.create(
    name: "User#{num}",
    email: "user#{num}@gmail.com",
    username: "user#{num}",
    password: "password"
  )
end

longitude_range = (70.0..90.0)
latitude_range = (8.0..35.0)

# Create Public Locations
100.times do
  Location.create(
    latitude: rand(latitude_range),
    longitude: rand(longitude_range)
  )

  location_ids = Location.pluck(:id)
  user_ids = User.pluck(:id)

  SharedLocation.create(
    location_id: location_ids.sample, 
    shared_by_id: user_ids.sample
  )
end

# Create shared locations
100.times do
  location_ids = []
  location = Location.create(
    latitude: rand(latitude_range),
    longitude: rand(longitude_range)
  )

  location_ids << location.id
  user_ids = User.pluck(:id)

  SharedLocation.create(
    location_id: location_ids.sample, 
    shared_by_id: user_ids.sample,
    shared_with_id: user_ids.sample)
end

