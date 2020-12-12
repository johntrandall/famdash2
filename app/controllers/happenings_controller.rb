class HappeningsController < ApplicationController
  def create
    happening_template = HappeningTemplate.where(id: happening_params_from_template[:template_id]).first
    user = User.find(happening_params_from_template[:user_id])
    raise unless happening_template.users.include? user

    Happening.create!(user: user,
                      reporting_user: current_user,
                      kind: happening_template.kind,
                      point_value: happening_template.point_value,
                      description: happening_template.description)

    redirect_back fallback_location: root_path
  end

  def happening_params_from_template
    params.permit(:user_id, :template_id)
  end
end
