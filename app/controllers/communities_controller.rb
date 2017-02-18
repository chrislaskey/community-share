class CommunitiesController < ApplicationController

  before_action :authenticate_user!
  before_action -> { require_role :admin }
  before_action :find_community

  def index
    @communities = current_user
      .memberships
      .select(&:active)
      .map(&:community)
      .sort_by(&:name)

    if @communities.length < 2
      return redirect_to "/documents"
    end

    render "index", layout: "login"
  end

  def login
    current_user
      .memberships
      .find_by!(community_id: params[:id])
      .login

    redirect_to "/documents"
  end

  def edit
  end

  def update
    if read_only?
      flash[:notice] = "Current community is read only"
      return render "edit"
    end

    if @community.update_attributes(permitted_params)
      flash[:success] = "Successfully updated #{@community.name}"
      redirect_to "/"
    else
      flash[:error] = @community.errors.full_messages
      render "edit"
    end
  end

  private

  def find_community
    @community = current_community
  end

  def permitted_params
    params.require(:community).permit(:uid, :name, :slug, :description)
  end

end
