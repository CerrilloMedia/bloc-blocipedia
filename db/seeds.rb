# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

10.times do
    User.create!(
        email: RandomData.random_email,
        password: "password"
    )
end

users = User.all

20.times do
    Wiki.create!(
        title: RandomData.random_sentence,
        body: RandomData.random_paragraph,
        user: users.sample,
        private: [true,false].sample
        )
end

puts "#{User.all.count} sample users created!"
puts "#{Wiki.all.count} sample Wikis created!"