class MembershipsBulkController < ApplicationController
  respond_to :html

  before_action :authenticate_user!
  before_action -> { require_role :admin }
  before_action :require_community

  def new
    @bulk_membership = BulkMembership.new
  end

  def create
    if read_only?
      flash[:notice] = "Current community is read only"
      return redirect_to new_memberships_bulk_path
    end

    if current_community.over_limit? :membership_count
      flash[:error] = "Over the maximum membership count for the current subscription level"
      return redirect_to new_memberships_bulk_path
    end

    @bulk_membership = BulkMembership.new(permitted_params)
    @bulk_membership.community = current_community

    if current_community.over_limit? :membership_count, @bulk_membership.count
      flash[:error] = "New memberships will exceed the maximum membership count for the current subscription level"
      return redirect_to memberships_path
    end

    unless @bulk_membership.create
      flash[:error] = @bulk_membership.errors.full_messages
    end

    respond_with @bulk_membership, location: memberships_path

    # @user = User.find_or_create_by(permitted_user_params)
    # @membership = Membership.new(permitted_membership_params)

    # @membership.community = current_community
    # @membership.user = @user

    # if @membership.save
    #   flash[:success] = "Successfully created #{@membership.user.email}"
    #   redirect_to memberships_path
    # else
    #   flash[:error] = @membership.errors.full_messages
    #   render "new"
    # end
  end

  private

  def permitted_params
    params.require(:bulk_membership).permit(:role, :data)
  end
end
