class AddHabitsEnabledToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :habits_enabled, :boolean
    User.where(display_name: ['Max', 'Sam', 'John']).update_all(habits_enabled: true)
  end
end
