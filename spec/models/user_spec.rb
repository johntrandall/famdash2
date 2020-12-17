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
  it 'works' do
    expect(User.new)
  end

  describe "#decay_good_habit_score" do
    it 'drops the good_habit_score by half, rounding up' do
      user = User.create!
      user.happenings.create!(point_value: '99')
      expect { user.decay_good_habit_score }.to change { user.good_habit_score }.from(99).to(50)
    end
  end

end
