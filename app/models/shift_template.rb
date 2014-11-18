class ShiftTemplate < ActiveRecord::Base
  belongs_to :company
  has_many :shifts

  def format_start_time
    time = self.start_time
    format_time(time)
  end

  def format_end_time
    time = self.end_time
    format_time(time)
  end

  private
  def format_time(time)
    hours = time / 60
    prefix = (hours < 12) ? "am" : "pm"
    hours -= 12 if hours >= 13
    minutes = time % 60
    minutes = "0#{minutes}" if minutes < 10
    "#{hours}:#{minutes}#{prefix}"
  end
end
