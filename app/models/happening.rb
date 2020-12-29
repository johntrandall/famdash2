class Happening < ApplicationRecord
  belongs_to :user
  belongs_to :reporting_user, class_name: User.to_s, optional: true

  enum event_kind: { habit_success: 'habit_success',
                     habit_pair: 'habit_pair',
                     habit_fail: 'habit_fail'}
end

# == Schema Information
#
# Table name: happenings
#
#  id                :bigint           not null, primary key
#  description       :string
#  event_kind        :string
#  name              :string
#  point_value       :integer
#  template_kind     :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  reporting_user_id :bigint
#  user_id           :bigint
#
# Indexes
#
#  index_happenings_on_reporting_user_id  (reporting_user_id)
#  index_happenings_on_user_id            (user_id)
#
