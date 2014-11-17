class AddDateToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :date, :date
  end
end
