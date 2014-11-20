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
    assigned_shifts.where(set:true).each do |shift|
      shift_hash = {
        time_string: shift.time_string,
        date: shift.date,
        id: shift.id,
        shift_template_id: shift.shift_template_id
      }
      assigned_shift_array << shift_hash
    end
    assigned_shift_array
  end

  def pending_requests
    accepted_requests_array = self.accepted_requests.where(pending: true)
    made_requests_array = self.made_requests.where(pending: true)
    accepted_requests_array + made_requests_array
  end
  def has_pending_requests
    pending_requests.length > 0
  end

  def request_pending_approval
    accepted_requests_array = self.accepted_requests.where(pending: true, admin_id: nil)
    made_requests_array = self.made_requests.where(pending: true, admin_id: nil)
    accepted_requests_array + made_requests_array
  end

  def made_request_with_approval
    self.made_requests.where(pending: true, admin_id: !nil)
  end

  def given_request_with_approval
    self.accepted_requests.where(pending: true, admin_id: !nil)
  end

  def has_requests_pending_approval
    request_pending_approval.length > 0
  end

  def shifts_for_pick_up
    shifts = []
    company.users.each do |user|
      if user.id != self.id
        shifts << user.made_request_with_approval
      end
    end
    shifts.flatten
  end
  
  def shifts_to_give
    shifts = []
    company.users.each do |user|
      if user.id != self.id
        shifts << user.given_request_with_approval
      end
    end
    shifts.flatten
  end

  def shifts_array
    shifts = []
    assigned_shifts.each do |shift|
      shifts << "#{shift.shift_template_id} - #{shift.date}"
    end
    shifts
  end

  def has_shifts_to_pick_up
    has = false
    shifts_for_pick_up.each do |request|
      has = true if !(self.shifts_array.include? "#{request.shift.shift_template_id} - #{request.shift.date}")
    end
    has
  end

  def has_shifts_to_give
    has = false
    shifts_to_give.each do |request|
      has = true if (self.shifts_array.include? "#{request.shift.shift_template_id} - #{request.shift.date}")
    end
    has
  end
end
