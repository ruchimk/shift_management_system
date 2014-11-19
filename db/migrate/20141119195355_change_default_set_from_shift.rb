class ChangeDefaultSetFromShift < ActiveRecord::Migration
  def change
    change_column :shifts, :set, :boolean, :default => true

  end
end
