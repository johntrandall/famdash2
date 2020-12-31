class HappeningTemplate < ApplicationRecord
  acts_as_list scope: [:user_id], touch_on_update: false

  belongs_to :user
  has_many :happenings
  scope :active, -> { all }

  enum kind: { separator: 'separator',
               good_habit: 'good_habit',
               bad_habit: 'bad_habit',
               pass_fail_habit: 'pass_fail_habit' }

  def streak_kind
    @streak_kind ||= happenings.order(created_at: :desc).first&.event_kind&.to_sym
  end

  def streak_count(count: 1, occurrence_date: happenings.send(streak_kind).maximum(:created_at))
    prior_date = occurrence_date - 1.day
    range = (prior_date).beginning_of_day...(prior_date).end_of_day

    if happenings.send(streak_kind).where(created_at: range).present?
      count += 1
      streak_count(count: count, occurrence_date: prior_date)
    else
      return count
    end
  end

  # def success_streak
  #   return unless happenings.order(:created_at, :desc).first.entry_kind == habit_success
  #
  #   happenings.habit_success.count
  # end
  #
  # def pass_streak
  #   return unless happenings.order(:created_at, :desc).first.entry_kind == habit_pass
  #
  #   happenings.habit_success.count
  # end
  #
  # def fail_streak
  #   return unless happenings.order(:created_at, :desc).first.entry_kind == habit_fail
  #
  #   happenings.habit_fail.count
  # end
end

# == Schema Information
#
# Table name: happening_templates
#
#  id                  :bigint           not null, primary key
#  description         :string
#  kind                :string
#  name                :string
#  point_value         :integer
#  position            :integer
#  show_fail_button    :boolean          default(FALSE)
#  show_pass_button    :boolean          default(FALSE)
#  show_success_button :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_happening_templates_on_user_id  (user_id)
#
