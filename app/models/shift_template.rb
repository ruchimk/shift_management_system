class ShiftTemplate < ActiveRecord::Base
  belongs_to :company
  has_many :shifts
end
