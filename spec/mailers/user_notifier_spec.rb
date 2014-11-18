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

    it 'assigns @user' do
      expect(mail.body.encoded).to match(user)
    end
  end
end
