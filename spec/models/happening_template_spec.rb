require 'rails_helper'

RSpec.describe HappeningTemplate do

  let(:user) { user = User.create! }
  let(:template) { template = HappeningTemplate.create!(user: user) }

  describe '#streak_kind' do
    it 'reports the kind of the last entry' do
      selected_user_yesterday = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_fail, user: user, created_at: 1.day.ago)
      selected_user_today = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_success, user: user)

      expect(template.streak_kind).to eq :habit_success
    end
  end

  describe '#success_count' do
    it 'counts the daily streak for a user' do
      minus_3 = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_success, user: user, created_at: 4.days.ago)
      minus_3 = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_fail, user: user, created_at: 3.days.ago)
      minus_2 = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_success, user: user, created_at: 2.days.ago)
      minus_1 = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_success, user: user, created_at: 1.day.ago)
      minus_0 = Happening.create(name: 'streaker', happening_template: template, event_kind: :habit_success, user: user, created_at: Time.current)

      expect(template.streak_count).to eq 3
    end
  end

  describe '#enable_card?' do
    context '#allowed_entires is nil' do
      let(:template) { HappeningTemplate.create!(user: user, allowed_entries_daily_count: nil) }
      it 'returns true' do
        expect(template.enable_card?).to be true
      end
    end

    context '#allowed_entires is zero' do
      let(:template) { HappeningTemplate.create!(user: user, allowed_entries_daily_count: 0) }
      it 'returns true' do
        expect(template.enable_card?).to be true
      end
    end

    context '#allowed_entires is 1, and we have 0' do
      let(:template) { HappeningTemplate.create!(user: user, allowed_entries_daily_count: 1) }
      let!(:yesterday_happening) { Happening.create(user: user, happening_template: template, created_at: 1.day.ago) }
      it 'returns true' do
        expect(template.enable_card?).to be true
      end
    end

    context '#allowed_entires is 1, and we have 1' do
      let(:template) { HappeningTemplate.create!(user: user, allowed_entries_daily_count: 1) }
      let!(:happening) { Happening.create(user: user, happening_template: template) }
      let!(:yesterday_happening) { Happening.create(user: user, happening_template: template, created_at: 1.day.ago) }
      it 'returns false' do
        expect(template.enable_card?).to be false
      end
    end
  end
end

# == Schema Information
#
# Table name: happening_templates
#
#  id                          :bigint           not null, primary key
#  allowed_entries_daily_count :integer
#  description                 :string
#  kind                        :string
#  name                        :string
#  point_value                 :integer
#  position                    :integer
#  show_fail_button            :boolean          default(FALSE)
#  show_pass_button            :boolean          default(FALSE)
#  show_success_button         :boolean          default(TRUE)
#  created_at                  :datetime         not null
#  updated_at                  :datetime         not null
#  user_id                     :bigint
#
# Indexes
#
#  index_happening_templates_on_user_id  (user_id)
#
