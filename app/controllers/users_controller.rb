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

  def assigned_shifts
    user = User.find(params[:id])
    shifts = user.assigned_shifts_hash
    respond_to do |format|
      format.json { render json: shifts}
    end
  end


end
