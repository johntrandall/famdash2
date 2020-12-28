class HappeningsController < ApplicationController
  def create
    reporting_user = User.find(happening_params[:reporting_user_id])
    reportee_user = User.find(happening_params[:selected_user_id])

    happening_template = reportee_user.happening_templates.find(happening_params[:template_id])
    event_kind = happening_params[:event_kind]

    Happening.create!(user: reportee_user,
                      reporting_user: reporting_user,
                      event_kind: event_kind,
                      **happening_template.attributes.except('id',
                                                             'kind',
                                                             'created_at',
                                                             'updated_at',
                                                             'position',
                                                             'show_success_button',
                                                             'show_pass_button',
                                                             'show_fail_button',
                                                             'user_id')
    )

    redirect_back fallback_location: root_path
  end

  def happening_params
    params.permit(:selected_user_id,
                  :reporting_user_id,
                  :template_id,
                  :event_kind)
  end
end
