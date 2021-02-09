
require 'rails_helper'

RSpec.describe User, type: :model do
  define_negated_matcher :not_change, :change

  it 'works' do
    expect(User.new)
  end

end

# == Schema Information
#
# Table name: users
#
#  id             :bigint           not null, primary key
#  display_name   :string
#  habits_enabled :boolean
#  role           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
