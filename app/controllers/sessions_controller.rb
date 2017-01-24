class SessionsController < ApplicationController

  def create
		request.env["omniauth.auth"]
  end

end
