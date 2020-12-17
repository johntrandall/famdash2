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
require 'rails_helper'

RSpec.describe User, type: :model do
  define_negated_matcher :not_change, :change

  it 'works' do
    expect(User.new)
  end

  describe '.decay_good_habit_scores!' do
    it 'decays the children' do
      child = User.create!(role: :child)
      child.happenings.create(point_value: 100)
      not_child = User.create!(role: :caretaker)
      not_child.happenings.create(point_value: 100)

      expect { User.decay_good_habit_scores! }.
        to change { child.good_habit_score }.
          and not_change { not_child.good_habit_score }
    end
  end

  describe "#decay_good_habit_score!" do
    it 'drops the good_habit_score by half, rounding up' do
      user = User.create!
      user.happenings.create!(point_value: '99')
      expect { user.decay_good_habit_score! }.to change { user.good_habit_score }.from(99).to(50)
    end
  end

end
