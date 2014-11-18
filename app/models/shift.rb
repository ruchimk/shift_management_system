class Shift < ActiveRecord::Base
    belongs_to :employee, class_name: 'User', foreign_key: 'employee_id'
    belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
    belongs_to :shift_template
    has_many :requests

    def time_string
      "#{self.shift_template.format_start_time} - #{self.shift_template.format_end_time}"
    end

end
