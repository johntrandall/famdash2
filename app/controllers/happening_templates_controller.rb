class HappeningTemplatesController < ApplicationController
  def index
    (redirect_back(fallback_location: root_path) and return) if selected_user.nil?
    @happening_templates = selected_user.happening_templates
  end
end
