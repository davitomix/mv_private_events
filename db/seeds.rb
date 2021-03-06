# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command (or created
# alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)
User.create!(name: 'Example User',
             email: 'example@railstutorial.org',
             password: 'foobar',
             password_confirmation: 'foobar')

9.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

switcher = false
users = User.all
10.times do
  users.each do |user|
    if switcher
      user.events.create!(name: Faker::Lorem.sentence(word_count: 3),
                          description: Faker::Lorem.sentence(word_count: 5),
                          creator_id: user.id,
                          location: Faker::Lorem.sentence(word_count: 5),
                          scheduled: Time.now + 10.days + 5.hours)
    else
      user.events.create!(name: Faker::Lorem.sentence(word_count: 3),
                          description: Faker::Lorem.sentence(word_count: 5),
                          creator_id: user.id,
                          location: Faker::Lorem.sentence(word_count: 5),
                          scheduled: Time.now - 10.days - 5.hours)
    end
    switcher = !switcher
  end
end

events = Event.all
counter = 1

events.each do |event|
  5.times do
    user = User.find_by(id: counter)
    event.attendees << user
    counter += 1
  end
  counter = 1
end
