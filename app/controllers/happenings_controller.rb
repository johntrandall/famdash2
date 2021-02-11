class HappeningsController < ApplicationController

  def index
  end

  def grid_index
    @grid = HappeningsGrid.new({ order: :created_at, descending: true }.merge(grid_params)) do |scope|
      scope.page(params[:page])
    end

  end

  def create
    reporting_user = User.find(happening_params[:reporting_user_id])
    reportee_user = User.find(happening_params[:selected_user_id])

    happening_template = reportee_user.happening_templates.find(happening_params[:template_id])
    event_kind = happening_params[:event_kind]
    score_from_template = happening_template.send(event_kind)

    # raise "TODO finish handling fail conditions here, and in decay"
    Happening.create!(user: reportee_user,
                      reporting_user: reporting_user,
                      reported_at: Time.current,
                      happening_template: happening_template,
                      event_kind: event_kind,
                      point_value: score_from_template,
                      **happening_template.attributes.except('id',
                                                             'kind',
                                                             'created_at',
                                                             'updated_at',
                                                             'position',
                                                             'good_habit_hit_score',
                                                             'good_habit_pass_score',
                                                             'good_habit_miss_score',
                                                             'good_habit_fail_score',
                                                             'bad_habit_avoid_score',
                                                             'bad_habit_exception_score',
                                                             'bad_habit_fail_score',
                                                             'show_success_button',
                                                             'show_pass_button',
                                                             'show_fail_button',
                                                             'user_id',
                                                             'allowed_entries_daily_count')
    )

    redirect_to root_path(anchor: "template_card-#{happening_template.id}")
  end

  def edit
    @happening = Happening.find(params[:id])
  end

  def update
    @happening = Happening.find(params[:id])

    deleted_at = happening_params[:deleted_at] ? Time.current : nil
    @happening.update!(happening_params.merge(deleted_at: deleted_at))

    flash[:success] = 'saved'
    redirect_back(fallback_location: edit_happening_path(@happening))
  end

  protected

  def happening_params_old
    params.permit(:selected_user_id,
                  :reporting_user_id,
                  :template_id,
                  :event_kind)

  end

  def happening_params
    params
      .require(:happening)
      .permit(:selected_user_id,
              :reporting_user_id,
              :template_id,
              :event_kind,
              :name,
              :description,
              :point_value,
              :deleted_at)
  end

  def grid_params
    params.fetch(:happenings_grid, {}).permit!
  end
end
