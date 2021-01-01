class Happening
  class OvernightExponentialDecayService
    ALLOW_HOUR = 1

    def self.run_all
      date_time = DateTime.current.in_time_zone("America/New_York")
      if date_time.hour == ALLOW_HOUR
        User.where(display_name: 'Max').each do |user|
          new.call(user)
        end
      end
    end

    def call(user)
      user.create_happening_to_decay_habit_success_score!
      user.create_happening_to_decay_habit_fail_score!
    end
  end
end
