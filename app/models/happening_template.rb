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

  # def streak_count(count: 1, occurrence_date: Time.current)
  #   current_streak_kind = current_streak_kind
  #   return 0 unless 'all todays happenings match current kind'
  #   return 0 unless 'all yesterdays happenings match current kind'
  #
  #   happened_today = happenings.send(current_streak_kind).maximum(:reported_at)
  #   count = 1 if happened_today
  #
  #   prior_date = occurrence_date - 1.day
  #   range = (prior_date).beginning_of_day...(prior_date).end_of_day
  #
  #   if happenings.send(current_streak_kind).where(reported_at: range).present?
  #     count += 1
  #     streak_count(count: count, occurrence_date: prior_date)
  #   else
  #     return count
  #   end
  # end
  #
  def streak_count
    success_count

  end

  def success_count(count: 0, day_range: nil)
    return 0 if happenings.not_decay.order(reported_at: :desc).first.habit_fail?

    count = 0

    day_range = Time.current.beginning_of_day..Time.current
    day_happenings = happenings.not_decay.where(reported_at: day_range)
    day_successes = day_happenings.habit_success
    day_fails = day_happenings.habit_fail
    if (day_fails.exists? && day_successes.empty?)
      return count
    end
    if (day_fails.empty? && day_successes.exists?)
      count+=1
    end
    if day_fails.exists? && day_successes.exists?
      if day_successes.maximum(:reported_at) > day_fails.maximum(:reported_at)
        count+=1
        return count
      end
    end

    day_range = (Time.current - 1.day).beginning_of_day..(Time.current - 1.day).end_of_day
    day_happenings = happenings.not_decay.where(reported_at: day_range)
    day_successes = day_happenings.habit_success
    day_fails = day_happenings.habit_fail
    if (day_fails.exists? && day_successes.empty?)
      return count
    end
    if (day_fails.empty? && day_successes.exists?)
      count+=1
    end
    if day_fails.exists? && day_successes.exists?
      if day_successes.maximum(:reported_at) > day_fails.maximum(:reported_at)
        count+=1
        return count
      end
    end

    day_range = (Time.current - 2.day).beginning_of_day..(Time.current - 2.day).end_of_day
    day_happenings = happenings.not_decay.where(reported_at: day_range)
    day_successes = day_happenings.habit_success
    day_fails = day_happenings.habit_fail
    if (day_fails.exists? && day_successes.empty?)
      return count
    end
    if (day_fails.empty? && day_successes.exists?)
      count+=1
    end
    if day_fails.exists? && day_successes.exists?
      if day_successes.maximum(:reported_at) > day_fails.maximum(:reported_at)
        count+=1
        return count
      end
    end

    day_range = (Time.current - 3.day).beginning_of_day..(Time.current - 3.day).end_of_day
    day_happenings = happenings.not_decay.where(reported_at: day_range)
    day_successes = day_happenings.habit_success
    day_fails = day_happenings.habit_fail
    if (day_fails.exists? && day_successes.empty?)
      return count
    end
    if (day_fails.empty? && day_successes.exists?)
      count+=1
    end
    if day_fails.exists? && day_successes.exists?
      if day_successes.maximum(:reported_at) > day_fails.maximum(:reported_at)
        count+=1
        return count
      end
    end

    day_range = (Time.current - 4.day).beginning_of_day..(Time.current - 4.day).end_of_day
    day_happenings = happenings.not_decay.where(reported_at: day_range)
    day_successes = day_happenings.habit_success
    day_fails = day_happenings.habit_fail
    if (day_fails.exists? && day_successes.empty?)
      return count
    end
    if (day_fails.empty? && day_successes.exists?)
      count+=1
    end
    if day_fails.exists? && day_successes.exists?
      if day_successes.maximum(:reported_at) > day_fails.maximum(:reported_at)
        count+=1
        return count
      end
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
