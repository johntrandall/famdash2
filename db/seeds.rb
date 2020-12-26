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

# HappeningTemplate

User.child.each do |child_user|
  # user.happening_templates.destroy_all!
  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    description: 'morning',
                                                    point_value: 0)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    description: 'Waking up on time',
                                                    point_value: 1)
  child_user.happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                    description: 'Exercising, after starting on time',
                                                    point_value: 5)
  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    description: 'In the morning, made bed upon waking up',
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                    description: 'In the morning, remembered to brush',
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    description: 'mealtime',
                                                    point_value: 0)
  child_user.happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                    description: 'before eating, remembered to wash hands',
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                    description: 'after mealtime, remembered to cleanup',
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                    description: 'When arriving home, put everything away immediately',
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    description: 'Ready for evening by the time parents are done with work',
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    description: 'Finshed everyhthing after dinner in < 15min',
                                                    point_value: 10)

  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    description: 'evening',
                                                    point_value: 0)
  child_user.happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                    description: 'before bed, remembered to floss and brush at night',
                                                    point_value: 5)
  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    description: 'before bed, remembered to cleanup bedroom',
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :bad_habit,
                                                    description: 'Getting distracted while working with Dad.')
            .update(point_value: -5)

  child_user.happening_templates.find_or_create_by!(kind: :bad_habit,
                                                    description: 'Distracting others while working on chores.')
            .update(point_value: -5)
end

User.where(display_name: ['Max', 'Sam']).each do |child_user|
  child_user.happening_templates
            .find_or_create_by!(kind: :bad_habit,
                                description: 'Leaving a trail')
            .update!(point_value: -10)
  child_user.happening_templates
            .find_or_create_by!(kind: :bad_habit,
                                description: 'Saying something is done that is not done')
            .update(point_value: -20)
end

User.find_by(display_name: 'Max').happening_templates.find_or_create_by!(kind: :bad_habit,
                                                                         description: 'Garbage left in a bad state.').update(point_value: -20)

User.find_by(display_name: 'Sam').happening_templates.find_or_create_by!(kind: :bad_habit,
                                                                         description: 'Saying something is done that is not done').update(point_value: -20)

User.find_by(display_name: 'Sam').happening_templates.find_or_create_by!(kind: :bad_habit,
                                                                         description: 'Getting distracted while working on chores.').update(point_value: -5)

User.find_by(display_name: 'Finn').happening_templates.find_or_create_by!(kind: :pass_fail_habit,
                                                                          description: 'Cleaning up quickly at cleanup time').update(point_value: 5)

# User.where(display_name: 'TestChild').destroy_all
# test_child = User.create!({ display_name: 'TestChild',
#                             role: :child })
# test_child.happenings.create!(reporting_user: test_child,
#                               kind: :good_habit,
#                               point_value: 5,
#                               description: 'i am a happening description')
# happening_template = HappeningTemplate.where(kind: :good_habit,
#                                              point_value: 5).first_or_create!
# happening_template.description ||= 'remembered to wash hands before eating'
# happening_template.save!
# happening_template.users << test_child
