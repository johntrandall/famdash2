class User < ApplicationRecord
  BASE_SCORE = 100

  has_many :happenings

  enum role: { child: 'child', caretaker: 'caretaker' }

  def name
    display_name
  end

  def habit_score
    BASE_SCORE + happenings.sum(:point_value)
  end
end
