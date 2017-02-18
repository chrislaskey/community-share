class ApplicationController < ActionController::Base

  protect_from_forgery prepend: true

  def current_community
    return nil unless current_user
    @current_community ||= current_user.current_community
  end

  def read_only?
    current_community.read_only
  end

  def community_type?(*types)
    return false unless current_community.present?
    return false unless current_community.level.present?
    current_community.level.slug.to_sym.in? types
  end

  def require_community_type(*types)
    return render file: "public/404.html", status: 404, layout: false unless community_type?(*types)
  end

  def require_community
    return redirect_to user_log_out_path unless current_community.present?
  end

  def role?(*roles)
    return false unless current_user.present?
    return false unless current_user.memberships.present?
    current_user.role(current_community).to_sym.in? roles
  end

  def require_role(*roles)
    return render file: "public/404.html", status: 404, layout: false unless role?(*roles)
  end

  def reject_role(*roles)
    return render file: "public/404.html", status: 404, layout: false if role?(*roles)
  end

  helper_method :current_community
  helper_method :current_user
  helper_method :role?
  helper_method :community_type?

end
