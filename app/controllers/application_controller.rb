class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception, prepend: true

  def current_community
    @current_community ||= Community.first
  end

  def has_role?(*roles)
    return false unless current_user.present?
    return false unless current_user.memberships.present?
    current_user.role(current_community).to_sym.in? roles
  end

  def require_role(*roles)
    return render file: "public/404.html", status: 404, layout: false unless has_role?(*roles)
  end

  def is_type?(*types)
    return false unless current_community.present?
    current_community.subscription_type.to_sym.in? types
  end

  def require_type?(*types)
    return render file: "public/404.html", status: 404, layout: false unless has_type?(*types)
  end

  helper_method :current_community
  helper_method :current_user
  helper_method :has_role?

end
