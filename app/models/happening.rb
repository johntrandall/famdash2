class Happening < ApplicationRecord
  belongs_to :user
  belongs_to :reporting_user, class_name: User.to_s, optional: true
  belongs_to :happening_template, optional: true

  enum event_kind: { habit_success: 'habit_success',
                     good_habit_hit_score: 'good_habit_hit_score',
                     good_habit_pass_score: 'good_habit_pass_score',
                     good_habit_miss_score: 'good_habit_miss_score',
                     good_habit_fail_score: 'good_habit_fail_score',
                     habit_success_decay: 'habit_success_decay',
                     habit_pair: 'habit_pair',
                     habit_fail: 'habit_fail' }

  default_scope { where(deleted_at: [nil]) }
  scope :not_decay, -> { where(decay_event: [false, nil]) }
  scope :habit_success_inclusive, -> { where(event_kind: ['habit_success',
                                                          'good_habit_hit_score',
                                                          'good_habit_miss_score',
                                                          'good_habit_pass_score',
                                                          'good_habit_fail_score']) }

  after_update :rerun_decay

  def rerun_decay
    Happening::DecayFactory.new.call(user)
  end
end

# == Schema Information
#
# Table name: happenings
#
#  id                    :bigint           not null, primary key
#  decay_event           :boolean
#  deleted_at            :datetime
#  description           :string
#  event_kind            :string
#  name                  :string
#  point_value           :integer
#  reported_at           :datetime
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  happening_template_id :bigint
#  reporting_user_id     :bigint
#  user_id               :bigint
#
# Indexes
#
#  index_happenings_on_happening_template_id  (happening_template_id)
#  index_happenings_on_reporting_user_id      (reporting_user_id)
#  index_happenings_on_user_id                (user_id)
#
