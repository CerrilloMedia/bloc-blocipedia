# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

10.times do
    email = Faker::Internet.email
    password = Faker::Internet.password
    User.create!( email: email, password: password )
end

users = User.all

20.times do
    Wiki.create!(
        title: Faker::Lorem.sentence(5),
        body: Faker::Lorem.paragraph(3,false,4),
        user: users.sample,
        private: [true,false, false].sample
        )
end

puts "#{Wiki.all.count} wiki's created."
puts "#{User.all.count} users created."