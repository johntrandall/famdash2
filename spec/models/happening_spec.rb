# == Schema Information
#
# Table name: happenings
#
#  id          :bigint           not null, primary key
#  description :string
#  kind        :string
#  point_value :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_happenings_on_user_id  (user_id)
#
require 'rails_helper'

RSpec.describe Happening, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  it 'works' do

  end
end
