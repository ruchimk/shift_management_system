class RequestController < ApplicationController

	# before_filter :authorize, only: [:edit, :update, :new]


	def index
		@requests = Request.all
	end

	def new
		@request = Request.new
	end

	def create
		@request = Request.new(request_params)

		@request.save
		redirect_to @request
	end

	def show
		@request = Request.find(params[:id])
	end

	private
	def request_params
		params.require(:request).permit(:title, :text)
	end

end
