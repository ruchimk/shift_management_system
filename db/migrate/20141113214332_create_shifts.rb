class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.string :time
      t.integer :admin_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
