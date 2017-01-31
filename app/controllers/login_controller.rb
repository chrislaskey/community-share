class LoginController < ApplicationController

  layout "login"

  def index
    redirect_to "/documents" if current_user
  end

end
