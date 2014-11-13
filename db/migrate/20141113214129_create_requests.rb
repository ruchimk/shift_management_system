class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requester_id
      t.integer :accepter_id
      t.integer :admin_id
      t.boolean :availability
      t.integer :shift_id

      t.timestamps
    end
  end
end
