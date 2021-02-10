class AddMultipleScoresToHabitTempateMore < ActiveRecord::Migration[6.1]
  class HappeningTemplate < ApplicationRecord
    enum kind: { separator: 'separator',
                 good_habit: 'good_habit',
                 bad_habit: 'bad_habit',
                 pass_fail_habit: 'pass_fail_habit' }

  end

  def change
    add_column :happening_templates, :bad_habit_avoid_score, :integer
    add_column :happening_templates, :bad_habit_exception_score, :integer
    add_column :happening_templates, :bad_habit_fail_score, :integer

    HappeningTemplate.bad_habit.each do |template|
      template.update!(bad_habit_avoid_score: nil)
      template.update!(bad_habit_exception_score: nil)
      template.update!(bad_habit_fail_score: template.show_fail_button ? -template.point_value : nil)
    end
  end
end
