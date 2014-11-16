class User < ActiveRecord::Base
    belongs_to :company
    has_many :made_requests, class_name: "Request", foreign_key: "requester_id"
    has_many :accepted_requests, class_name: "Request", foreign_key: "accepter_id"
    has_many :approved_requests, class_name: "Request", foreign_key: "admin_id"
    has_many :assigned_shifts, class_name: "Shift", foreign_key: "employee_id"
    has_many :managed_shifts, class_name: "Shift", foreign_key: "admin_id"


 def send_welcome_email
  UserNotifier.welcome_email.deliver()
end


end
