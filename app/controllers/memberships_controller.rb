class MembershipsController < ApplicationController

  before_action -> { require_role :admin }
  before_action :authenticate_user!
  before_action :find_membership, only: [:show, :edit, :update, :destroy]

  def index
    @memberships = Membership.includes(:user).in_community(current_community).paginate(page: params[:page]).order("role")
  end

  def show
  end

  def new
    @membership = Membership.new
  end

  def create
    if community_type? :read_only
      flash[:notice] = "Current community is read only"
      return render "new"
    end

    @user = User.find_or_create_by(permitted_user_params)
    @membership = Membership.new(permitted_membership_params)

    @membership.community = current_community
    @membership.user = @user

    if @membership.save
      flash[:success] = "Successfully created #{@membership.user.email}"
      redirect_to memberships_path
    else
      flash[:error] = @membership.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    if community_type? :read_only
      flash[:notice] = "Current community is read only"
      return render "edit"
    end

    if updating_own_role?
      flash[:error] = "Can not modify own role"
      return render "edit"
    end

    if @membership.update_attributes(permitted_membership_params)
      flash[:success] = "Successfully updated #{@membership.user.email}"
      redirect_to memberships_path
    else
      flash[:error] = @membership.errors.full_messages
      render "edit"
    end
  end

  def destroy
    if community_type? :read_only
      flash[:notice] = "Current community is read only"
      return redirect_to memberships_path
    end

    if current_user?
      flash[:error] = "Can not remove own membership"
      return redirect_to memberships_path
    end

    @membership.destroy

    flash[:success] = "Successfully deleted #{@membership.user.email}"
    redirect_to memberships_path
  end

  private

  def find_membership
    @membership ||= Membership.in_community(current_community).find(params[:id])
  end

  def permitted_membership_params
    params.require(:membership).permit(:role)
  end

  def permitted_user_params
    params.require(:user).permit(:email, :name)
  end

  def current_user?
    @membership.user == current_user
  end

  def updating_own_role?
    current_user? && current_user.role(current_community) != params[:membership][:role]
  end

end
