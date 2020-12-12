class CreateHappeningTemplatesUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :happening_templates_users do |t|
      t.references :happening_template
      t.references :user
      t.timestamps
    end
  end
end
