class AddShiftTemplateIdToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :shift_template_id, :integer
  end
end
