class UsersController < ApplicationController
  def create
    # Create the user from params
    @user = User.new(params[:user])
    if @user.save
      # Deliver the welcome email
      UserNotifier.welcome_email(@user).deliver
      redirect_to(@user, :notice => 'Signed up successfully!')
    else
      render :action => 'new'
    end
  end
end
