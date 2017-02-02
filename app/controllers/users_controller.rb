class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :find_user, only: [:show, :edit, :update]

  def index
    @users = User.all.order(:role, :name)
  end

  def show

  end

  def edit

  end

  def update
    if updating_own_role?
      flash[:error] = ["Can not modify own user role"]
      return render "edit"
    end

    if @user.update_attributes(permitted_params)
      flash[:success] = ["Successfully updated #{@user.name}"]
      redirect_to @user
    else
      flash[:error] = @user.errors.full_messages
      render "edit"
    end
  end

  private

  def find_user
    @user ||= User.find(params[:id])
  end

  def permitted_params
    params.require(:user).permit(:role)
  end

  def updating_own_role?
    current_user.id.to_s == params[:id] && current_user.role != params[:user][:role]
  end

end
