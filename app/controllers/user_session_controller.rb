class UserSessionController < ApplicationController
  def new   
    @user_session = UserSession.new
  end
  
  def create
    session = UserSession.new(params[:user_session])
    if session.save
      redirect_to user_url(current_user)
    else
      render :action => :new
    end
  end

  def destroy
    session = UserSession.find
    session.destroy
    redirect_to login_url
  end

end
