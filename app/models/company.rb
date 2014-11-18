class Company < ActiveRecord::Base
    has_many :users
    has_many :shift_templates

    def admins
    	users.admins
    end

    def employees
    	users.employees
    end
end
