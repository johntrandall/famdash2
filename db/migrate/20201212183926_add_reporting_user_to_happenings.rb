class AddReportingUserToHappenings < ActiveRecord::Migration[6.1]
  def change
    add_reference :happenings, :reporting_user
  end
end
