class AddKindsToHappening < ActiveRecord::Migration[6.1]
  def change
    add_column :happenings, :event_kind, :string
    add_column :happenings, :template_kind, :string
    remove_column :happenings, :kind, :string
  end
end
