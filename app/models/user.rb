class User < ActiveRecord::Base
  before_create :send_welcome_email
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

  def self.admins
    where(is_admin: true)
  end

  def self.employees
    where(is_admin: false)
  end

  def send_welcome_email
    UserNotifier.welcome_email(self).deliver()
  end

  def assigned_shifts_hash
    assigned_shift_array = []
    assigned_shifts.each do |shift|
      shift_hash = {
        time_string: shift.time_string,
        date: shift.date,
        id: shift.id
      }
      assigned_shift_array << shift_hash
    end
    assigned_shift_array
  end
end
