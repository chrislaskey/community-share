class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception, prepend: true

  helper_method :current_user

end
