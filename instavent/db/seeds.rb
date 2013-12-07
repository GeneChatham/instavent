# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.destroy_all
puts "Destroyed all events"

events = [
  {tag: "halloween2013" },
  {tag: "worldseries" },
  {tag: "mkshackathon" },
  {tag: "mks3" },
  {tag: "yolo" }
]

puts "Creating five events"
events.each do |event|
  Event.create(tag: event[:tag])
end
puts "Created five events"
