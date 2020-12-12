class CreateHappenings < ActiveRecord::Migration[6.1]
  def change
    create_table :happenings do |t|
      t.string :kind
      t.string :description
      t.integer :point_value
      t.references :user
      t.timestamps
    end
  end
end
