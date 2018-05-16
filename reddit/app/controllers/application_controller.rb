class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :signed_in?
  
  
  def sign_in(user)
    @current_user = user
    session[:session_token] = user.reset_session_token
  end
  
  def signout
    current_user.reset_session_token
    session[:session_token] = nil
  end
  
  def signed_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def require_sign_in
    redirect_to new_session_url unless signed_in?
  end
  
  
end