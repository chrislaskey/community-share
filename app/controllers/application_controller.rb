class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception, prepend: true

  def has_role?(*roles)
    current_user.role.to_sym.in? roles
  end

  def require_role(*roles)
    return render file: "public/404.html", status: 404, layout: false unless has_role?(*roles)
  end

  helper_method :current_user
  helper_method :has_role?

end
