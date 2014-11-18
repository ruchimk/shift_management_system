class CreateShiftTemplates < ActiveRecord::Migration
  def change
    create_table :shift_templates do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :company_id
      t.integer :duration

      t.timestamps
    end
  end
end
