class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    member = Member.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Member.create_with_omniauth(auth)
    session[:member_id] = member.id
    redirect_to root_url, :notice => "Signed in" 
  end
  
  def destroy
    session[:member_id] = nil
    redirect_to root_url, :notice => "Successfully signed out"
  end
end

