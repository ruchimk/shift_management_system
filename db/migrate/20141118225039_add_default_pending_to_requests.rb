class AddDefaultPendingToRequests < ActiveRecord::Migration
  def change
    change_column :requests, :pending, :boolean, :default => false
  end
end
