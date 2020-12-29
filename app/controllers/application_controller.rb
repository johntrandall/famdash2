class ApplicationController < ActionController::Base
  helper_method :current_user, :selected_user

  private

  def current_user
    # if session[:current_user_login_at] && (session[:current_user_login_at].to_datetime + 5.minutes > Time.current)
      @current_user ||= User.find_by(id: session[:current_user_id])
    # else
    #   flash[:error] = 'Login expired - did not record - identify yourself first'
    #   redirect_to root_path and return
    # end
  end

  def selected_user
    @selected_user ||= User.find_by(id: session[:selected_user_id])
  end
end
