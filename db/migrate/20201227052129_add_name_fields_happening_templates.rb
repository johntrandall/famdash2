class AddNameFieldsHappeningTemplates < ActiveRecord::Migration[6.1]
  def change
    add_column :happenings, :name, :string
    add_column :happening_templates, :name, :string
    add_column :happening_templates, :show_success_button, :boolean, default: :true
    add_column :happening_templates, :show_pass_button, :boolean, default: :false
    add_column :happening_templates, :show_fail_button, :boolean, default: :false
  end
end
