class ApplicationController < ActionController::Base
  helper_method :current_user, :selected_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def selected_user
    @selected_user ||= User.find_by(id: session[:selected_user_id])
  end
end
