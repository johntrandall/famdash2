class HappeningTemplatesController < ApplicationController
  def index
    if selected_user.nil? || current_user.nil?
      redirect_back(fallback_location: root_path)
      return
    end
    @happening_templates = selected_user.happening_templates
  end

  def create
    selected_user.happening_templates.create! happening_template_params
    flash[:success] = 'Habit created'

    redirect_back(fallback_location: happening_templates_path)
  end

  def update
    happening_template = selected_user.happening_templates.find(params[:id])
    # TODO - permissions
    happening_template.update!(happening_template_params)
    flash[:success] = 'Habit updated'

    redirect_back(fallback_location: happening_templates_path)
  end

  def destroy
    happening_template = selected_user.happening_templates.find(params[:id])
    happening_template.destroy!
    flash[:success] = 'Habit deleted'

    redirect_back(fallback_location: happening_templates_path)
  end

  def sort_higher
    happening_template = selected_user.happening_templates.find(params[:id])
    happening_template.decrement_position
    flash[:success] = 'Order adjusted'

    redirect_back(fallback_location: happening_templates_path)
  end

  def sort_down
    happening_template = selected_user.happening_templates.find(params[:id])
    happening_template.increment_position
    flash[:success] = 'Order adjusted'

    redirect_back(fallback_location: happening_templates_path)
  end

  private

  def happening_template_params
    params.require(:happening_template).permit(:name,
                                               :kind,
                                               :point_value,
                                               :description,
                                               :show_success_button, :show_pass_button, :show_fail_button,
                                               :allowed_entries_daily_count)
  end
end
