class ChangeDefaultPendingToRequests < ActiveRecord::Migration
  def change
    change_column :requests, :pending, :boolean, :default => true
  end
end
