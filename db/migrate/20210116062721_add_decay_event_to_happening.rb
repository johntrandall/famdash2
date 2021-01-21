class AddDecayEventToHappening < ActiveRecord::Migration[6.1]
  def change
    add_column :happenings, :decay_event, :boolean
  end
end
