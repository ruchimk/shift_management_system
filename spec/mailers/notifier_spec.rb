# spec/mailers/notifier_spec.rb
require 'spec_helper'

describe UserNotifier do
  describe 'instructions' do
    let(:user) { mock_model User, name: 'Lucas', email: 'lucas@email.com' }
    let(:mail) { UserNotifier.send_signup_email(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('Thanks for signing up for Shiftable!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['noreply@company.com'])
    end

    it 'assigns @user' do
      expect(mail.body.encoded).to match(user)
    end

    it 'assigns @confirmation_url' do
      expect(mail.body.encoded).to match("http://aplication_url/#{user.id}/confirmation")
    end
  end
end
