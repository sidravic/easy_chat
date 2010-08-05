class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully Registered"
      redirect_to user_url(@user)
    else
      render :action => "new"
    end
  end

  def show
   
  end

  def edit
  end

  def update
  end

  def delete
  end
  
  def setup_notification
    XmppClient.accept_subscription_from(params[:uid], params[:pres])
    respond_to do |format|
      format.js { render :text => "Completed"  }
    end
  end

end
