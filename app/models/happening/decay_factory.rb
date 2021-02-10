class Happening
  class DecayFactory
    def self.run_all
      User.habits_enabled.each do |user|
        new.call(user)
      end
    end

    def call(user)
      array_of_last_7_days = (7.days.ago.to_date...Time.current.to_date).uniq

      array_of_last_7_days.each do |date|
        create_habit_success_decay(date, user)
        # create_habit_fail_decay(date, user)
      end
    end

    private

    def create_habit_fail_decay(date, user)
      cumulative_fail_score_to_date = user.happenings.habit_fail_and_decay_inclusive.where(reported_at: [...date.beginning_of_day])
                               .sum(:point_value)
      fail_score_change_that_should_happen_begining_of_day = -1 * (cumulative_fail_score_to_date / 3)

      if fail_score_change_that_should_happen_begining_of_day.nonzero?
        decay_happening = user.happenings.find_or_create_by!(event_kind: :habit_fail_decay,
                                                             decay_event: true,
                                                             reported_at: date.beginning_of_day)
        if decay_happening.point_value != fail_score_change_that_should_happen_begining_of_day
          decay_happening.update!(name: 'fail score heal',
                                  description: 'fail score overnight forgiveness - loose 1/3',
                                  point_value: fail_score_change_that_should_happen_begining_of_day)
        end
      end
    end

    def create_habit_success_decay(date, user)
      cumulative_sucess_score_to_date = user.happenings.habit_success_and_decay_inclusive.where(reported_at: [...date.beginning_of_day]).sum(:point_value)
      success_score_change_that_should_happen_begining_of_day = -1 * (cumulative_sucess_score_to_date / 3)

      # if success_score_change_that_should_happen_begining_of_day.nonzero?
        decay_happening = user.happenings.find_or_create_by!(event_kind: :habit_success_decay,
                                                             decay_event: true,
                                                             reported_at: date.beginning_of_day)
        # if decay_happening.point_value != success_score_change_that_should_happen_begining_of_day_day
          decay_happening.update!(name: 'success score fade',
                                  description: 'success score overnight fade - loose (1/3)',
                                  point_value: success_score_change_that_should_happen_begining_of_day)
        # end
      # end
    end
  end
end
