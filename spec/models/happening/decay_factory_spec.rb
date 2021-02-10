require 'rails_helper'

describe Happening::DecayFactory do
  describe '.run_all' do
    it 'calls for Max' do
      max_user = User.create(display_name: 'Max', habits_enabled: true)
      mock_service = instance_double(Happening::DecayFactory)
      expect(Happening::DecayFactory).to receive(:new).and_return(mock_service)
      expect(mock_service).to receive(:call).with(max_user)

      Happening::DecayFactory.run_all
    end
  end

  describe '#call' do
    it 'generates success decay events' do
      user = User.create(display_name: 'Max')
      Happening.create!(user: user, event_kind: :habit_success, decay_event: nil, reported_at: 10.days.ago.noon, point_value: 300)

      Happening::DecayFactory.new.call(user)

      # expect { Happening::DecayFactory.new.call(user) }.to change { Happening.count }.by 7
      # expect(Happening.where(decay_event: true).pluck(:point_value)).to match_array [-100, -66, -44, -30, -20, -13, -9]
    end

    it 're-writes decay events' do
      user = User.create(display_name: 'Max')
      Happening.create!(user: user, event_kind: :good_habit_hit_score, reported_at: 10.days.ago.noon, point_value: 300)

      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 7.days.ago.beginning_of_day, point_value: -1)
      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 6.days.ago.beginning_of_day, point_value: -1)
      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 5.days.ago.beginning_of_day, point_value: -1)

      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 3.days.ago.beginning_of_day, point_value: -1)

      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 1.days.ago.beginning_of_day, point_value: -1)

      # expect { Happening::DecayFactory.new.call(user) }.to change { Happening.count }.by 2
       Happening::DecayFactory.new.call(user)
      expect(Happening.habit_success_decay.pluck(:point_value)).to match_array [-100, -66, -44, -30, -20, -13, -9]
    end

    it 'generates fail decay events' do
      user = User.create(display_name: 'Max')
      Happening.create!(user: user, event_kind: :good_habit_hit_score, reported_at: 10.days.ago.noon, point_value: 300)

      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 7.days.ago.beginning_of_day, point_value: -1)
      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 6.days.ago.beginning_of_day, point_value: -1)
      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 5.days.ago.beginning_of_day, point_value: -1)

      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 3.days.ago.beginning_of_day, point_value: -1)

      Happening.create!(user: user, event_kind: :habit_success_decay, decay_event: true, reported_at: 1.days.ago.beginning_of_day, point_value: -1)

      expect { Happening::DecayFactory.new.call(user) }.to change { Happening.count }.by 2
      expect(Happening.habit_success_decay.pluck(:point_value)).to match_array [-100, -66, -44, -30, -20, -13, -9]
    end
  end
end
