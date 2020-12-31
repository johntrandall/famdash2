
require 'rails_helper'

RSpec.describe User, type: :model do
  define_negated_matcher :not_change, :change

  it 'works' do
    expect(User.new)
  end

  describe "#create_happening_to_decay_habit_success_score!!" do
    it 'drops the good_habit_score by 1/3, rounding up' do
      user = User.create!
      user.happenings.create!(event_kind: 'habit_success', point_value: '99')
      expect { user.create_happening_to_decay_habit_success_score!; user.reload }.to change { user.good_habit_score }.from(99).to(66)
    end
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
