# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do
  task = Task.new(
    description:  Faker::ChuckNorris.fact,
    completed:    [true, false].sample,
    due_date:     Faker::Date.between(3.months.ago.to_date, 3.months.from_now.to_date)
  )
  task.due_date = nil if [true, false].sample
  task.save!
end

puts "#{Task.count} tasks in the system..."
