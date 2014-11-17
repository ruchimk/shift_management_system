class Request < ActiveRecord::Base
	belongs_to :user
	belongs_to :requester, class_name: "User", foreign_key: "requester_id"
	belongs_to :accepter, class_name: "User", foreign_key: "accepter_id"
	belongs_to :admin, class_name: "User", foreign_key: "admin_id"
	belongs_to :shift
end
