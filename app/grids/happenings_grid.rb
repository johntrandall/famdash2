class HappeningsGrid < BaseGrid

  scope do
    Happening.includes(:happening_template)
  end

  # filter(:id, :integer)
  # filter(:created_at, :date, :range => true)

  date_column(:created_at)
  column(:id)
  column(:name)
  column(:description)
  column(:event_kind)
  column(:point_value)
  column(:happening_template_id, :header => "Template ID")
  column(:happening_template, :header => "Template Name") { |temp| temp.name }
end
