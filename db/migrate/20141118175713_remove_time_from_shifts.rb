class RemoveTimeFromShifts < ActiveRecord::Migration
  def change
    remove_column :shifts, :time, :string
  end
end
