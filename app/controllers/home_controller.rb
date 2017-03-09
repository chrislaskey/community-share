class HomeController < ApplicationController

  include Memberships

  layout "home"

  before_action :create_registration

  def index
    clear_params_cookie
    redirect_to "/documents" if current_user
  end

  def register
    return render "index" unless @registration.valid?

    unless current_user
      store_params_in_cookie
      return redirect_to "#{user_facebook_omniauth_authorize_path}?origin=/register"
    end

    return render "index" unless validate_admin_membership_count

    create_community
    create_admin_membership
    clear_current_membership
    update_memberships

    clear_params_cookie
    redirect_to "/documents"
  end

  private

  def create_registration
    @registration = CommunityRegistration.new(registration_params)
  end

  def stored_params
    if cookies[:registration_params].present?
      return ActionController::Parameters.new(
        JSON.parse(cookies[:registration_params])
      )
    end

    params
  end

  def registration_params
    stored_params.permit(
      :terms_agreement,
      :community_name,
      :community_level
    )
  end

  def store_params_in_cookie
    cookies[:registration_params] = registration_params.to_json
  end

  def clear_params_cookie
    cookies.delete :registration_params
  end

  def validate_admin_membership_count
    if Membership.admin_memberships(current_user).count > Membership::ADMIN_ROLE_LIMIT
      @registration.errors << "Can not be an admin of more than #{Membership::ADMIN_ROLE_LIMIT} communities"
      return false
    end

    true
  end

  def create_community
    community = Community.create(
      name: registration_params[:community_name]
    )

    community_level = CommunityLevel.find_by(
      slug: registration_params[:community_level]
    )

    CommunitySubscription.create(
      community: community,
      community_level: community_level,
      started_at: Time.now
    )
  end

  def create_admin_membership
    community = Community.find_by(
      name: registration_params[:community_name]
    )

    Membership.create(
      community: community,
      user: current_user,
      role: Membership::ADMIN_ROLE
    )
  end

end
