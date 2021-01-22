class HappeningTemplate < ApplicationRecord
  acts_as_list scope: [:user_id], touch_on_update: false

  belongs_to :user
  has_many :happenings
  scope :active, -> { all }

  enum kind: { separator: 'separator',
               good_habit: 'good_habit',
               bad_habit: 'bad_habit',
               pass_fail_habit: 'pass_fail_habit' }

  def current_streak_kind
    @streak_kind ||= happenings.order(reported_at: :desc).first&.event_kind&.to_sym
  end

  def streak_count
    case current_streak_kind
      when :habit_success
        success_streak_count
      when :habit_fail
        fail_streak_count
    end

  end

  def success_streak_count(count: 0, day_range: nil)
    return 0 if happenings.not_decay.order(reported_at: :desc).first.habit_fail?

    count = 0
    (0..4).uniq.each do |num|
      day_range = (Time.current - num.day).beginning_of_day..(Time.current - num.day).end_of_day
      day_happenings = happenings.not_decay.where(reported_at: day_range)
      habits_to_quantify = day_happenings.habit_success
      habits_to_break_streak = day_happenings.habit_fail
      count += 1 if (habits_to_break_streak.empty? && habits_to_quantify.exists?)
      return count if (habits_to_break_streak.exists? && habits_to_quantify.empty?)
      return count if habits_to_break_streak.exists? && habits_to_quantify.exists? && habits_to_quantify.maximum(:reported_at) < habits_to_break_streak.maximum(:reported_at)
      return count += 1 if habits_to_break_streak.exists? && habits_to_quantify.exists? && habits_to_quantify.maximum(:reported_at) > habits_to_break_streak.maximum(:reported_at)
    end

    return count
  end

  def fail_streak_count(count: 0, day_range: nil)
    return 0 if happenings.not_decay.order(reported_at: :desc).first.habit_success?

    count = 0
    (0..4).uniq.each do |num|
      day_range = (Time.current - num.day).beginning_of_day..(Time.current - num.day).end_of_day
      day_happenings = happenings.not_decay.where(reported_at: day_range)
      habits_to_quantify = day_happenings.habit_fail
      habits_to_break_streak = day_happenings.habit_success
      count += 1 if (habits_to_break_streak.empty? && habits_to_quantify.exists?)
      return count if (habits_to_break_streak.exists? && habits_to_quantify.empty?)
      return count if habits_to_break_streak.exists? && habits_to_quantify.exists? && habits_to_quantify.maximum(:reported_at) < habits_to_break_streak.maximum(:reported_at)
      return count += 1 if habits_to_break_streak.exists? && habits_to_quantify.exists? && habits_to_quantify.maximum(:reported_at) > habits_to_break_streak.maximum(:reported_at)
    end

    return count
  end

  def enable_card?
    return true if (allowed_entries_daily_count.nil? || allowed_entries_daily_count.zero?)

    entries_today = user.happenings
                        .where(happening_template: self,
                               created_at: DateTime.current.in_time_zone("America/New_York").beginning_of_day...DateTime.current.in_time_zone("America/New_York").end_of_day)
                        .count
    entries_today < allowed_entries_daily_count
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
