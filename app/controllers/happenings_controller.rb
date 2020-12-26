class HappeningsController < ApplicationController
  def create
    reporting_user = User.find(happening_params_from_template[:reporting_user_id])
    reportee_user = User.find(happening_params_from_template[:selected_user_id])
    happening_template = reportee_user.happening_templates.find(happening_params_from_template[:template_id])

    Happening.create!(user: reportee_user,
                      reporting_user: reporting_user,
                      kind: happening_template.kind,
                      point_value: happening_template.point_value,
                      description: happening_template.description)

    redirect_back fallback_location: root_path
  end

  def happening_params_from_template
    params.permit(:selected_user_id, :reporting_user_id, :template_id)
  end
end
