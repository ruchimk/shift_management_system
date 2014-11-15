# spec/models/user_spec.rb
require 'spec_helper'

describe User do
  let(:user) { User.make }

  it "sends an email" do
    expect { user.welcome_email }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end
