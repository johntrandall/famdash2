class AddDeletedAtToHappening < ActiveRecord::Migration[6.1]
  def change
    add_column :happenings, :deleted_at, :datetime
  end
end
