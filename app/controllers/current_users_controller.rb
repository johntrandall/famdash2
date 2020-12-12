class CurrentUsersController < ApplicationController
  def update
    session[:current_user_id] = params.fetch(:id)
    redirect_back fallback_location: root_path
  end
end
