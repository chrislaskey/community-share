class HomeController < ApplicationController

  layout "home"

  def index
    redirect_to "/documents" if current_user
  end

end
