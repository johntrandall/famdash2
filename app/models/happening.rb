# == Schema Information
#
# Table name: happenings
#
#  id                :bigint           not null, primary key
#  description       :string
#  kind              :string
#  point_value       :integer
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
class Happening < ApplicationRecord
  belongs_to :user
  belongs_to :reporting_user, class_name: User.to_s
end
