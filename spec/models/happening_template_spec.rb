
require 'rails_helper'

RSpec.describe HappeningTemplate, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: happening_templates
#
#  id                  :bigint           not null, primary key
#  description         :string
#  kind                :string
#  name                :string
#  point_value         :integer
#  position            :integer
#  show_fail_button    :boolean          default(FALSE)
#  show_pass_button    :boolean          default(FALSE)
#  show_success_button :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  user_id             :bigint
#
# Indexes
#
#  index_happening_templates_on_user_id  (user_id)
#
