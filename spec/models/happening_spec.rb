
require 'rails_helper'

RSpec.describe Happening, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'works' do
    user = User.create!
    user.happenings.create!
  end

  describe 'update' do
    it 'callbacks to Happening::DecayFactory' do
      user = User.create!
      happening = user.happenings.create!

      expect(Happening::DecayFactory).to receive(:new).and_return(mock_decay_factory = instance_double(Happening::DecayFactory))
      expect(mock_decay_factory).to receive(:call).with(user)

      happening.update!(name: 'foo')
    end
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
