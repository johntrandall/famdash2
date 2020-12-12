# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

RANDALL_USER_DATA = [
  { display_name: 'Max',
    role: :child },
  { display_name: 'Sam',
    role: :child },
  { display_name: 'Finn',
    role: :child },
  { display_name: 'John',
    role: :caretaker },
  { display_name: 'Karina',
    role: :caretaker },
  { display_name: 'Natt',
    role: :caretaker },
  { display_name: 'Don',
    role: :caretaker },
  { display_name: 'Janet',
    role: :caretaker },
]

# User.destroy_all
# RANDALL_USER_DATA.each do |data|
#   User.create!(data)
# end

User.where(display_name: 'TestChild').destroy_all
test_child = User.create!({ display_name: 'TestChild',
                            role: :child })
Happening.create!(user: test_child,
                 kind: :good_habit,
                 point_value: 5)
