class HomeController < ApplicationController

  before_action :create_registration

  layout "home"

  def index
    redirect_to "/documents" if current_user
  end

  def register
    unless @registration.valid?
      flash[:error] = @registration.errors
      return render "index"
    end
  end

  private

  def create_registration
    @registration = CommunityRegistration.new(registration_params)
  end

  def registration_params
    params.permit(
      :terms_agreement,
      :community_name,
      :community_level
    )
  end

end
