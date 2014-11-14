class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    belongs_to :company
    has_many :made_requests, class_name: "Request", foreign_key: "requester_id"
    has_many :accepted_requests, class_name: "Request", foreign_key: "accepter_id"
    has_many :approved_requests, class_name: "Request", foreign_key: "admin_id"
    has_many :assigned_shifts, class_name: "Shift", foreign_key: "employee_id"
    has_many :managed_shifts, class_name: "Shift", foreign_key: "admin_id"
end
