class HappeningsGrid < BaseGrid

  scope do
    Happening.includes(:happening_template)
  end

  # filter(:id, :integer)
  # filter(:created_at, :date, :range => true)

  date_column(:created_at)
  # column(:event_kind)
  column(:event_kind) do |happening|
    if happening.habit_success?
      "✅"
    elsif happening.habit_fail?
      "❌"
    end
  end
  column(:decay_event, header: "heal?") do |happening|
    if happening.decay_event
      if happening.habit_fail?
        "🛌 💗"
      elsif happening.habit_success?
        "🛌 💗"
      end
    end
  end
  # column(:id)
  column(:point_value)
  column(:name)
  column(:description)
  # column(:happening_template_id, :header => "Template ID")
  column(:happening_template, :header => "Template")  do |teamplate|
    ActionController::Base.helpers.link_to_if( teamplate.id.present?,
                                               teamplate.name || teamplate.description,
                                               Rails.application.routes.url_helpers.happening_templates_path(anchor: "happeningTemplate-#{teamplate.id}"))
  end
  column(:id,  header: nil) do |happening|
    ActionController::Base.helpers.link_to('edit', Rails.application.routes.url_helpers.edit_happening_path(happening))
  end
end
