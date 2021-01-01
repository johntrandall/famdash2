class AddAllowedEntriesDailyCountToHappeningTemplate < ActiveRecord::Migration[6.1]
  def change
    add_column :happening_templates, :allowed_entries_daily_count, :integer
  end
end
