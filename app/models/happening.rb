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
class Happening < ApplicationRecord
  belongs_to :user
end
