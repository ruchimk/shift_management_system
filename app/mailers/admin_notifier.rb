class AdminMailer < ActionMailer::Base
  default to: Proc.new { current_user.company.admins.pluck(:email) },
          from: 'notification@shiftable.com'

  # send an email to all admins when user requests shift change
  def request_shiftchange(user)
    @user = user
    mail(subject: "#{@user.first_name} Requested a Shift Change")
  end

  def accept_shiftchange(user)
   @user = user
   mail(subject: "#{@user.first_name} Accepted a Shift Change")
  end

end


current_user.company.admins.each do |admin|
  UserNotifier.request_shiftchange(admin)
end
