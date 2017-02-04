class UsersController < ApplicationController

  before_action ->{ require_role :admin }
  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.in_community(current_community).paginate(page: params[:page]).order(:name, :email).sort_by do |user|
      user.role(current_community)
    end
  end

  def show

  end

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(permitted_user_params)

    if @user.save
      Membership.create(
        community: current_community,
        role: permitted_membership_params,
        user: @user
      )
      flash[:success] = ["Successfully created #{@user.name}"]
      redirect_to users_path
    else
      flash[:error] = @user.errors.full_messages
      render "new"
    end
  end

  def edit

  end

  def update
    if updating_own_role?
      flash[:error] = ["Can not modify own user role"]
      return render "edit"
    end

    if @user.update_attributes(permitted_user_params) && update_role
      flash[:success] = ["Successfully updated #{@user.name}"]
      redirect_to users_path
    else
      flash[:error] = @user.errors.full_messages
      render "edit"
    end
  end

  def destroy
    if is_current_user?
      flash[:error] = ["Can not remove own user"]
      return redirect_to users_path
    end

    @user.destroy

    flash[:success] = ["Successfully deleted #{@user.name}"]
    redirect_to users_path
  end

  private

  def find_user
    @user ||= User.find(params[:id])
  end

  def permitted_user_params
    params.require(:user).permit(:email, :name)
  end

  def permitted_membership_params
    params.require(:membership).permit(:role)
  end

  def is_current_user?
    current_user.id.to_s == params[:id]
  end

  def updating_own_role?
    is_current_user? && current_user.role != params[:membership][:role]
  end

  def update_role
    membership = @user.membership(current_community)
    membership.update_attributes(permitted_membership_params)
  end

end
