class HappeningTemplate < ApplicationRecord
  acts_as_list scope: [:user_id], touch_on_update: false

  belongs_to :user
  scope :active, -> { all }

  enum kind: { separator: 'separator',
               good_habit: 'good_habit',
               bad_habit: 'bad_habit',
               pass_fail_habit: 'pass_fail_habit' }
end

# == Schema Information
#
# Table name: happening_templates
#
#  id          :bigint           not null, primary key
#  description :string
#  kind        :string
#  point_value :integer
#  position    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint
#
# Indexes
#
#  index_happening_templates_on_user_id  (user_id)
#
