class DropTemplateKindFromHappening < ActiveRecord::Migration[6.1]
  def change
    remove_column :happenings, :template_kind, :string
  end
end
