class HappeningsController < ApplicationController

  def index
  end

  def grid_index
    @grid = HappeningsGrid.new({ order: :created_at, descending: true }.merge(grid_params)) do |scope|
      scope.page(params[:page])
    end

  end

  def create
    reporting_user = User.find(happening_params_old[:reporting_user_id])
    reportee_user = User.find(happening_params_old[:selected_user_id])

    happening_template = reportee_user.happening_templates.find(happening_params_old[:template_id])
    event_kind = happening_params_old[:event_kind]

    Happening.create!(user: reportee_user,
                      reporting_user: reporting_user,
                      event_kind: event_kind,
                      happening_template: happening_template,
                      **happening_template.attributes.except('id',
                                                             'kind',
                                                             'created_at',
                                                             'updated_at',
                                                             'position',
                                                             'show_success_button',
                                                             'show_pass_button',
                                                             'show_fail_button',
                                                             'user_id',
                                                             'allowed_entries_daily_count')
    )

    redirect_back fallback_location: root_path
  end

  def edit
    @happening = Happening.find(params[:id])
  end

  def update
    @happening = Happening.find(params[:id])
    @happening.update!(happening_params)

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
    params.require(:happening).permit(:selected_user_id,
                                      :reporting_user_id,
                                      :template_id,
                                      :event_kind,
                                      :name,
                                      :description,
                                      :point_value,
    )
  end

  def grid_params
    params.fetch(:happenings_grid, {}).permit!
  end
end
