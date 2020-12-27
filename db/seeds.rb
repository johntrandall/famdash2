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

HappeningTemplate.destroy_all

User.child.each do |child_user|
  # user.happening_templates.destroy_all!
  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    name: 'morning')

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'Waking up on time',
                                                    show_success_button: true,
                                                    point_value: 1)
  # expires_to_fail_time; 12pm

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'Exercise (full session and log)',
                                                    show_success_button: true,
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'Practice Music',
                                                    show_success_button: true,
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'morning routines promptly',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'Brushed immediately after breakfast',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 5)

  ##############################
  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    name: 'mealtime',
                                                    point_value: 0)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'before breakfast- washed hands without prompting',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'after breakfast- cleaned up promptly',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'before lunch- washed hands without prompting',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'after lunch- cleaned up promptly',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'before dinner- washed hands without prompting',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'after dinner- cleaned up promptly',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 1)

  ##############################
  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    name: 'evening',
                                                    point_value: 0)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'Done with responsibilies by the time parents are done with work',
                                                    show_success_button: true,
                                                    show_pass_button: true,
                                                    show_fail_button: true,
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'FAMILY GOAL: post dinner cleanup in less than 15min',
                                                    show_success_button: true,
                                                    show_pass_button: true,
                                                    show_fail_button: true,
                                                    point_value: 10)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'floss and brush before bed without prompting',
                                                    show_success_button: true,
                                                    show_fail_button: true,
                                                    point_value: 5)
                                                    # expire_to_fail_time: '24:00',

  child_user.happening_templates.find_or_create_by!(kind: :separator,
                                                    name: 'General',
                                                    point_value: 0)

  child_user.happening_templates.find_or_create_by!(kind: :good_habit,
                                                    name: 'Upon arriving home, put everything away immediately',
                                                    point_value: 5)

  child_user.happening_templates.find_or_create_by!(kind: :bad_habit,
                                                    name: 'Keeping Dad waiting.',
                                                    show_success_button: false,
                                                    show_pass_button: false,
                                                    show_fail_button: true,
                                                    point_value: -5)

  child_user.happening_templates.find_or_create_by!(kind: :bad_habit,
                                                    name: 'Distracting others while working on chores.',
                                                    show_success_button: false,
                                                    show_pass_button: false,
                                                    show_fail_button: true,
                                                    point_value: -5)
end

User.where(display_name: ['Max', 'Sam']).each do |child_user|
  child_user.happening_templates
            .find_or_create_by!(kind: :bad_habit,
                                name: 'Leaving a trail',
                                show_success_button: false,
                                show_pass_button: false,
                                show_fail_button: true,
                                point_value: -10)
  child_user.happening_templates
            .find_or_create_by!(kind: :bad_habit,
                                name: 'Saying something is done that is not done',
                                show_success_button: false,
                                show_pass_button: false,
                                show_fail_button: true,
                                point_value: -20)
end

User.find_by(display_name: 'Max').happening_templates
    .find_or_create_by!(kind: :bad_habit,
                        name: 'Garbage left in a bad state.',
                        show_success_button: false,
                        show_pass_button: false,
                        show_fail_button: true,
                        point_value: -20)

User.find_by(display_name: 'Sam').happening_templates
    .find_or_create_by!(kind: :bad_habit,
                        name: 'Saying something is done that is not done',
                        show_success_button: false,
                        show_pass_button: false,
                        show_fail_button: true,
                        point_value: -20)

User.find_by(display_name: 'Sam').happening_templates
    .find_or_create_by!(kind: :bad_habit,
                        name: 'Getting distracted while working on chores.',
                        show_success_button: false,
                        show_pass_button: false,
                        show_fail_button: true,
                        point_value: -5)

User.find_by(display_name: 'Finn').happening_templates
    .find_or_create_by!(kind: :pass_fail_habit,
                        name: 'Cleaning up quickly at cleanup time',
                        show_success_button: false,
                        show_pass_button: false,
                        show_fail_button: true,
                        point_value: 5)

# User.where(display_name: 'TestChild').destroy_all
# test_child = User.create!({ display_name: 'TestChild',
#                             role: :child })
# test_child.happenings.create!(reporting_user: test_child,
#                               kind: :good_habit,
#                               point_value: 5,
#                               name: 'i am a happening name')
# happening_template = HappeningTemplate.where(kind: :good_habit,
#                                              point_value: 5).first_or_create!
# happening_template.name ||= 'remembered to wash hands before eating'
# happening_template.save!
# happening_template.users << test_child
