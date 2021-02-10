class AddMultipleScoresToHabitTemplate < ActiveRecord::Migration[6.1]
  class HappeningTemplate < ApplicationRecord
    enum kind: { separator: 'separator',
                 good_habit: 'good_habit',
                 bad_habit: 'bad_habit',
                 pass_fail_habit: 'pass_fail_habit' }

  end

  def change
    add_column :happening_templates, :good_habit_hit_score, :integer
    add_column :happening_templates, :good_habit_pass_score, :integer
    add_column :happening_templates, :good_habit_miss_score, :integer
    add_column :happening_templates, :good_habit_fail_score, :integer

    HappeningTemplate.good_habit.each do |template|
      template.update!(good_habit_hit_score: (template.show_success_button ? template.point_value : nil))
      template.update!(good_habit_pass_score: (template.show_pass_button ? 0 : nil))
      template.update!(good_habit_miss_score: nil)
      template.update!(good_habit_fail_score: (template.show_fail_button ? -template.point_value : nil))
    end
  end
end
