class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'open-uri'
 
  
  protected
  def current_member
    @current_member ||= Member.find(session[:member_id]) if session[:member_id]
  end
  
  def signed_in?
    !!current_member
  end
  
  def current_member=(member)
    @current_member = member
    session[:member_id] = member.id
  end
  
  def admin?
    signed_in? && current_member.admin? 
    # session[:member_id] == 2
  end
  def owner?
    @member == current_member
  end

  def authorize
    unless admin?
      flash[:error] = "Sorry something went wrong. We have been notified and will fix it."
      redirect_to root_path
      false
    end
  end
 helper_method :current_member, :signed_in?, :admin?, :owner?, :authorize
end
