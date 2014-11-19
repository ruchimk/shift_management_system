class Request < ActiveRecord::Base
	belongs_to :requester, class_name: "User", foreign_key: "requester_id"
	belongs_to :accepter, class_name: "User", foreign_key: "accepter_id"
	belongs_to :admin, class_name: "User", foreign_key: "admin_id"
	belongs_to :shift

  def type_string
    availability ? "Available to Pick Up" : "Change Current Shift"
  end
end
