class HappeningTemplatesController < ApplicationController
  def index
    if selected_user.nil? || current_user.nil?
      redirect_back(fallback_location: root_path)
      return
    end
    @happening_templates = selected_user.happening_templates
  end

  def show
    @happening_template = selected_user.happening_templates.find(params[:id])
    @file_name = generate_graph_filename
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

  def generate_graph_filename
    file_name = "gruff/#{controller_name}_#{action_name}_#{@happening_template.id}.png"
    cache_key = "#{file_name}-#{@happening_template.happenings.minimum(:updated_at).to_i}"
    Rails.cache.fetch(cache_key) do
      write_graph_image(file_name)
    end
    file_name
  end

  def write_graph_image(file_name)
    array_of_dates = (14.days.ago.to_date...Time.current.to_date).uniq
    require 'gruff'
    g = Gruff::Bar.new
    g.title = @happening_template.name
    g.labels = array_of_dates
                 .each_with_index.map { |x, i| [i, x] }.to_h
                 .select { |k, v| v.strftime('%A') == "Monday" }
                 .transform_values.each { |v| v = v&.strftime('%A, %m/%d') }
    g.data(:successes,
           array_of_dates
             .map { |date| happening_template_happenings_habit_success_where = @happening_template.happenings.habit_success.where(reported_at: [date.beginning_of_day...date.end_of_day])
             happening_template_happenings_habit_success_where.count },
           '#33cc33')
    g.data(:fails,
           array_of_dates
             .map { |date| @happening_template.happenings.habit_fail.where(reported_at: [date.beginning_of_day...date.end_of_day]).count * -1 },
           '#ff0000')
    g.y_axis_increment = 1
    g.marker_font_size = 10
    g.no_data_message = 'no data'

    g.write("app/assets/images/#{file_name}")

    file_name
  end

  def happening_template_params
    params.require(:happening_template).permit(:name,
                                               :kind,
                                               :point_value,
                                               :description,
                                               :show_success_button, :show_pass_button, :show_fail_button,
                                               :allowed_entries_daily_count)
  end
end
