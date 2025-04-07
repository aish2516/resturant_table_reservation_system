# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

time_slots = [
  ["10:00 AM - 12:00 PM", "10:00", "12:00"],
  ["12:00 PM - 02:00 PM", "12:00", "14:00"],
  ["02:00 PM - 04:00 PM", "14:00", "16:00"],
  ["04:00 PM - 06:00 PM", "16:00", "18:00"],
  ["06:00 PM - 08:00 PM", "18:00", "20:00"],
  ["08:00 PM - 10:00 PM", "20:00", "22:00"]
]

time_slots.each do |label, start_time, end_time|
  TimeSlot.find_or_create_by!(label: label, start_time: start_time, end_time: end_time)
end
