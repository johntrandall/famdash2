class User < ApplicationRecord
  has_many :happenings
  alias good_habits :happenings

  has_many :happening_templates, -> { order(position: :asc) }
  alias good_habit_templates :happening_templates

  enum role: { child: 'child', caretaker: 'caretaker' }

  def self.decay_good_habit_scores!
    User.child.each do |child|
      child.decay_good_habit_score!
    end
  end

  def name
    display_name
  end

  def good_habit_score
    happenings.habit_success.sum(:point_value)
  end

  def bad_habit_score
    happenings.habit_fail.sum(:point_value)
  end


  # def decay_good_habit_score!
  #   happenings.create!(description: 'overnight decay',
  #                      point_value: -1 * (good_habit_score / 2))
  # end

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
