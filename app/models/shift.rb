class Shift < ActiveRecord::Base
    belongs_to :employee, class_name: 'User', foreign_key: 'employee_id'
    belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'
    belongs_to :shift_template
    has_many :requests

    def time_string
      shift_template.time_string
    end

end
