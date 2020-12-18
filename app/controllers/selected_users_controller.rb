class SelectedUsersController < ApplicationController
  def update
    session[:selected_user_id] = params.fetch(:id)
    redirect_back fallback_location: root_path
  end
end
