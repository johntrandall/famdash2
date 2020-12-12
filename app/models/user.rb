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
class User < ApplicationRecord
  BASE_SCORE = 100

  has_many :happenings
  has_and_belongs_to_many :happening_templates

  enum role: { child: 'child', caretaker: 'caretaker' }

  def name
    display_name
  end

  def good_habit_score
    BASE_SCORE + good_habits.sum(:point_value)
  end

  def good_habits
    happenings
  end

  def good_habit_templates
    happening_templates
  end

end
