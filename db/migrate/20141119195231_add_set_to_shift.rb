class AddSetToShift < ActiveRecord::Migration
  def change
    add_column :shifts, :set, :boolean
  end
end
