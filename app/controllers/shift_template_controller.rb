class ShiftTemplateController < ApplicationController
  def new
  end

  def create
    st = ShiftTemplate.create(shift_template_params)
    respond_to do |format|
      format.json { render json: {shiftTemplate: st, timeString: st.time_string}}
    end
  end

  private
  def shift_template_params
    params.require(:shift_template).permit(:start_time, :end_time, :company_id)
  end
end
