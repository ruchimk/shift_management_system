class AddPendingToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :pending, :boolean
  end
end
