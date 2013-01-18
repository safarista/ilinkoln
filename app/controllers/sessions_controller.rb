class SessionsController < ApplicationController
  def create
    member = Member.from_omniauth(env["omniauth.auth"])
    session[:member_id] = member.id
    redirect_to root_url, :notice => "Signed in" 

  end
  
  def destroy
    session[:member_id] = nil
    redirect_to root_url, :notice => "Successfully signed out"
  end
  
  def failure
    flash[:alert] = 'Authentication failed please try again.'
    redirect_to root_url
  end
end

