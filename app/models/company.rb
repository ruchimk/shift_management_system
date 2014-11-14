class Company < ActiveRecord::Base
    has_many :users

    def admins
    	users.admins
    end

    def employees
    	users.employees
    end
end
