# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password, :password_confirmation
  helper_method :current_user_session, :current_user

  before_filter :require_user
  before_filter :setup_host_for_mail
  before_filter :set_user_time_zone

  private

  def set_user_time_zone
    Time.zone = current_user.time_zone if current_user
  end

  # ActionMailer views don't have access to the request, so we need
  # to set these variables manually.
  def setup_host_for_mail
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] ||= "You must be logged in to access this page"
      render :template => "/home/index", :layout => "full_page"
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to "/"
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end
