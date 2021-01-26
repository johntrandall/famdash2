class Happening
  class DecayFactory
    def self.run_all
      User.where(display_name: 'Max').each do |user|
        new.call(user)
      end
    end

    def call(user)
      array_of_last_7_days = (7.days.ago.to_date...Time.current.to_date).uniq

      array_of_last_7_days.each do |date|
        sucess_score_to_date = user.happenings.where(event_kind: :habit_success, reported_at: [...date.beginning_of_day])
                                   .sum(:point_value)
        success_score_change = -1 * (sucess_score_to_date / 3)

        if success_score_change.nonzero?
          decay_happening = user.happenings.find_or_create_by!(event_kind: :habit_success,
                                                               decay_event: true,
                                                               reported_at: date.beginning_of_day)
          if decay_happening.point_value != success_score_change
            decay_happening.update!(name: 'success score fade',
                                    description: 'success score overnight fade - loose (1/3)',
                                    point_value: success_score_change)
          end
        end

        fail_score_to_date = user.happenings.where(event_kind: :habit_fail, reported_at: [...date.beginning_of_day])
                                 .sum(:point_value)
        fail_score_change = -1 * (fail_score_to_date / 3)

        if fail_score_change.nonzero?
          decay_happening = user.happenings.find_or_create_by!(event_kind: :habit_fail,
                                                               decay_event: true,
                                                               reported_at: date.beginning_of_day)
          if decay_happening.point_value != fail_score_change
            decay_happening.update!(name: 'fail score heal',
                                    description: 'fail score overnight forgiveness - loose 1/3',
                                    point_value: fail_score_change)
          end
        end

      end
    end
  end
end
