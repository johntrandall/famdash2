class AddReportedAtToHappenings < ActiveRecord::Migration[6.1]
  def change
    add_column :happenings, :reported_at, :datetime
  end
end
