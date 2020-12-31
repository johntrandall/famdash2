require 'rails_helper'

describe Happening::OvernightExponentialDecayService do
  describe ".run_all" do
    it 'calls for Max' do
      max_user = User.create(display_name: 'Max')
      mock_service = instance_double(Happening::OvernightExponentialDecayService)
      expect(Happening::OvernightExponentialDecayService).to receive(:new).and_return(mock_service)
      expect(mock_service).to receive(:call).with(max_user)

      Happening::OvernightExponentialDecayService.run_all
    end
  end

  describe "#call" do
    it 'calls the things on the user' do
      max_user = User.create(display_name: 'Max')
      expect(max_user).to receive(:create_happening_to_decay_habit_success_score!)
      expect(max_user).to receive(:create_happening_to_decay_habit_fail_score!)

      Happening::OvernightExponentialDecayService.new.call(max_user)
    end
  end
end
