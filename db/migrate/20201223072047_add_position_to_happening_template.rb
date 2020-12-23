class AddPositionToHappeningTemplate < ActiveRecord::Migration[6.1]
  def change
    add_column :happening_templates, :position, :integer
    User.all.each do |user|
      user.happening_templates.order(:updated_at).each.with_index(1) do |happening_templates, index|
        happening_templates.update_column :position, index
      end
    end
  end

end
