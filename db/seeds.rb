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
RANDALL_USER_DATA.each do |data|
  User.find_or_create_by!(data)
end

User.child.each do |user|
  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'In the morning, made bed upon waking up',
                                       point_value: 1).users << user

  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'In the morning, remembered to brush',
                                       point_value: 5).users << user


  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'before eating, remembered to wash hands',
                                       point_value: 1).users << user
  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'after mealtime, remembered to cleanup',
                                       point_value: 1).users << user



  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'When arriving home, remembered to put everything away immediately',
                                       point_value: 5).users << user


  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'before bed, remembered to floss and brush at night',
                                       point_value: 5).users << user
  HappeningTemplate.find_or_create_by!(kind: :good_habit,
                                       description: 'before bed, remembered to cleanup bedroom',
                                       point_value: 5).users << user

end

# User.find_by(display_name: 'Max').happening_templates.first_or_create!(kind: :good_habit,
#                                                    description: 'Remembered to cleanup bedroom in the morning',
#                                                    point_value: 5)
# User.find_by(display_name: 'Max').happening_templates.first_or_create!(kind: :good_habit,
#                                                    description: 'Remembered to brush in morning',
#                                                    point_value: 5)
# User.find_by(display_name: 'Max').happening_templates.first_or_create!(kind: :good_habit,
#                                                    description: 'Remembered to floss and brush at night',
#                                                    point_value: 5)

User.where(display_name: 'TestChild').destroy_all
test_child = User.create!({ display_name: 'TestChild',
                            role: :child })
test_child.happenings.create!(reporting_user: test_child,
                              kind: :good_habit,
                              point_value: 5,
                              description: 'i am a happening description')
happening_template = HappeningTemplate.where(kind: :good_habit,
                                             point_value: 5).first_or_create!
happening_template.description ||= 'remembered to wash hands before eating'
happening_template.save!
happening_template.users << test_child
