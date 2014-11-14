class Shift < ActiveRecord::Base
    belongs_to :employee, class_name: 'User', foreign_key: 'employee_id'
    belongs_to :admin, class_name: 'User', foreign_key: 'admin_id'

    
end
