class AddReasonToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :reason, :text
  end
end
