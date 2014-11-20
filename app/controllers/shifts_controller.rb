class ShiftsController < ApplicationController
  def assign_shift
    shift = Shift.create(shift_params)
    respond_to do |format|
      format.json { render json: {hi: shift}}
    end
  end

  def reports
  end

  def userReports
    @user = User.find(params[:user_id])
    render 'user_report', layout: false
  end

  private

  def shift_params
    params.require(:shift).permit(:employee_id, :date, :shift_template_id)
  end
end
