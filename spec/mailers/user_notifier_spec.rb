# spec/mailers/notifier_spec.rb
require 'rails_helper'

describe UserNotifier do
  describe 'welcome_email' do
    let(:user) { mock_model User, name: 'Lucas', email: 'lucas@email.com' }
    let(:mail) { UserNotifier.welcome_email(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Thanks for signing up for Shiftable!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['shiftable@gmail.com'])
    end
  end

  describe 'shiftchange_request_email(user)' do

    let(:user) { mock_model User, name: 'James', email: 'james@email.com', is_admin: true }
    let(:mail) { UserNotifier.shiftchange_request_email(user) }

    it 'renders the subject' do
      @user = user
      expect(mail.subject).to eql("#{@user.first_name} Requested a Shift Change")
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql(Proc.new{user.company.admin_emails})
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['shiftable@gmail.com'])
    end
  end
  describe 'shiftchange_response_email' do

     let(:user) { mock_model User, name: 'Ruchi', email: 'ruchi@email.com', is_admin: true }
     let(:mail) { UserNotifier.shiftchange_response_email(user) }

     it 'renders the subject' do
        @user = user
       expect(mail.subject).to eql("Status update regarding shift change request")
     end

     it 'renders the receiver email' do
       expect(mail.to).to eql(user.email)
     end

     it 'renders the sender email' do
       expect(mail.from).to eql(['shiftable@gmail.com'])
     end
   end

end
