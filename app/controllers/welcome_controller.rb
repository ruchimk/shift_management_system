class WelcomeController < ApplicationController
  def splash
    if user_signed_in?
        render 'admin'
    else
        render 'index'
    end
  end

  def dashboard
    render 'admin'
  end

    def requests
    render 'admin'
  end

end
