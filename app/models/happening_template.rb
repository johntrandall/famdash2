class HappeningTemplate < ApplicationRecord
  has_and_belongs_to_many :users
  scope :active, -> { all }

  enum kind: { good_habit: :good_habit,
               bad_habit: :bad_habit,
               pass_fail_habit: :pass_fail_habit }
end

# == Schema Information
#
# Table name: happening_templates
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
#  index_happening_templates_on_user_id  (user_id)
#
