class User < ApplicationRecord
  has_many :happenings
  alias good_habits :happenings

  has_many :happening_templates, -> { order(position: :asc) }
  alias good_habit_templates :happening_templates

  enum role: { child: 'child', caretaker: 'caretaker' }

  def name
    display_name
  end

  def good_habit_score
    happenings.habit_success.sum(:point_value)
  end

  def bad_habit_score
    happenings.habit_fail.sum(:point_value)
  end

  def create_happening_to_decay_habit_success_score!
    happenings.create!(description: 'overnight decay (third)',
                       event_kind: :habit_success,
                       point_value: -1 * (good_habit_score / 3))
  end

  def create_happening_to_decay_habit_fail_score!
    happenings.create!(description: 'overnight decay (half)',
                       event_kind: :habit_fail,
                       point_value: -1 * (bad_habit_score / 2))
  end
end

# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  display_name :string
#  role         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
