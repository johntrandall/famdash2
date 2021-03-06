class User < ApplicationRecord
  has_many :happenings
  alias good_habits :happenings

  has_many :happening_templates, -> { order(position: :asc) }
  alias good_habit_templates :happening_templates

  enum role: { child: 'child', caretaker: 'caretaker' }

  scope :habits_enabled, -> {where(habits_enabled: true)}

  def name
    display_name
  end

  def screentime_allowed?
    good_habit_score_threshold_satisfied? && bad_habit_score_threshold_satisfied?
  end

  def good_habit_score_threshold_satisfied?
    100 <= good_habit_score
  end

  def good_habit_score
    happenings.habit_success_and_decay_inclusive.sum(:point_value)
  end

  def bad_habit_score_threshold_satisfied?
    bad_habit_score <= 100
  end

  def bad_habit_score
    happenings.habit_fail_and_decay_inclusive.sum(:point_value)
  end

  def create_happening_to_decay_habit_success_score!(date:)

  end

  def create_happening_to_decay_habit_fail_score!(date:)
    score_to_date = happenings.where(event_kind: :habit_fail, reported_at: [...date.beginning_of_day]).sum(:point_value)
    score_change = -1 * (score_to_date / 3)
    if score_change.nonzero?
      happenings.create!(description: 'overnight decay (1/2)',
                         event_kind: :habit_fail,
                         point_value: score_change)
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id             :bigint           not null, primary key
#  display_name   :string
#  habits_enabled :boolean
#  role           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
