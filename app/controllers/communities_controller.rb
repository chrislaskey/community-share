class CommunitiesController < ApplicationController

  before_action :authenticate_user!
  before_action -> { require_role :admin }
  before_action :find_community

  def edit
  end

  def update
    if community_type? :read_only
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
