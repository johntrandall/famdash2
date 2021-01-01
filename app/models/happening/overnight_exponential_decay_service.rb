class Happening
  class OvernightExponentialDecayService
    def self.run_all
      date_time = DateTime.current.in_time_zone("America/New_York")
      if date_time.hour == 1
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
