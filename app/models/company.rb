class Company < ActiveRecord::Base
    has_many :users
    has_many :shift_templates

    def admins
    	users.admins
    end

    def admin_emails
      email_array = []
      admins.each do |admin|
        email_array << admin.email
      end
      email_array
    end
    def employees
    	users.employees
    end
end
