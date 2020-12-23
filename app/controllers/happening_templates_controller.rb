class HappeningTemplatesController < ApplicationController
  def index
    if selected_user.nil? || current_user.nil?
      redirect_back(fallback_location: root_path)
      return
    end
    @happening_templates = selected_user.happening_templates
  end

  def update
    happening_template = selected_user.happening_templates.find(params[:id])
    # TODO - permissions
    happening_template.update!(happening_template_params)
    flash[:success] = 'Habit updated'

    redirect_back(fallback_location: happening_templates_path)
  end

  private

  def happening_template_params
    params.require(:happening_template).to_unsafe_hash #TODO
  end
end
