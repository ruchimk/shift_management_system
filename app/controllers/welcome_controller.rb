class WelcomeController < ApplicationController
  def splash
    if user_signed_in?
        render 'admin'
    else
        render 'index'
    end
  end

  def dashboard
    render 'admin'
  end

  def assigned_shifts
    user = User.find(params[:id])
    shifts = user.assigned_shifts_hash
    respond_to do |format|
      format.json { render json: shifts}
    end
  end
end
