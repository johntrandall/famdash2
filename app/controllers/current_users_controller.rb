class CurrentUsersController < ApplicationController
  def update
    session[:current_user_id] = params.fetch(:id)
    session[:current_user_login_at] = Time.current

    redirect_back fallback_location: root_path
  end
end
