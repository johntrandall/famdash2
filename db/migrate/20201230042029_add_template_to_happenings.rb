class AddTemplateToHappenings < ActiveRecord::Migration[6.1]
  def change
    add_reference :happenings, :happening_template
  end
end
