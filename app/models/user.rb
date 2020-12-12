class User < ApplicationRecord
  BASE_SCORE = 100

  has_many :happenings

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
end
