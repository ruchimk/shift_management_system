require 'rails_helper'

RSpec.describe User, :type => :model do
	it "orders by last name" do
		lindeman = User.create!(first_name: "Andy", last_name: "Lindeman", email: "andy@ga.co", password: "password")
		chelimsky = User.create!(first_name: "David", last_name: "Chelimsky", email: "david@ga.co", password: "password")

		expect(User.ordered_by_last_name).to eq([chelimsky, lindeman])
	end
end

feature "Create Company" do

	def create_companies
		Company.new!(
			company_name: 'Company'
		)
	end

	scenario "with name given" do
		visit signup_path

		expect(Company.name).to eq "Company"
	end
end

feature "Create User" do

	def create_users
		User.new!(
			first_name: 'Babak',
			last_name: 'P',
			email: 'b@ga.co',
			password: 'password'
		)
	end

	scenario "with name given" do
		visit signup_path

		expect(User.name).to eq "User"
	end

	scenario "with name given" do
		visit signup_path

		expect(User.name).to eq "User"
	end
end
