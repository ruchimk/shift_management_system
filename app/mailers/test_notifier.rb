class TestNotifier < ActionMailer::Base
  default from: "shiftable@gmail.com"

   # send a signup email to the user, pass in the user object that   contains the user's email address
   def test_email
    mail(to: 'jamesjalandoni1@gmail.com') do |format|
      format.text { render text: "Hello Ruchi!" }
      format.html { render text: "<h1>Hello Ruchi!!!!!!</h1>" }
    end
   end
end
