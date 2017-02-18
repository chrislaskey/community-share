class TagsController < ApplicationController

  before_action :authenticate_user!
  before_action -> { require_role :admin, :editor }
  before_action :require_community
  before_action :find_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.in_community(current_community)
  end

  def show
    @documents = @tag.documents
  end

  def new
    @tag = Tag.new
  end

  def create
    if read_only?
      flash[:notice] = "Current community is read only"
      return redirect_to tags_path
    end

    if current_community.over_limit? :tag_count
      flash[:error] = "Over the maximum tag count for the current subscription level"
      return redirect_to tags_path
    end

    @tag = Tag.new(permitted_params)
    @tag.community = current_community

    if @tag.save
      flash[:success] = "Successfully created #{@tag.name}"
      redirect_to @tag
    else
      flash[:error] = @tag.errors.full_messages
      render "new"
    end
  end

  def edit
  end

  def update
    if read_only?
      flash[:notice] = "Current community is read only"
      return render "edit"
    end

    if @tag.update_attributes(permitted_params)
      flash[:success] = "Successfully updated #{@tag.name}"
      redirect_to @tag
    else
      flash[:error] = @tag.errors.full_messages
      render "edit"
    end
  end

  def destroy
    if read_only?
      return flash[:notice] = "Current community is read only"
    end

    @tag.destroy

    flash[:success] = "Successfully deleted #{@tag.name}"
    redirect_to tags_path
  end

  private

  def find_tag
    @tag ||= Tag.in_community(current_community).find(params[:id])
  end

  def permitted_params
    params.require(:tag).permit(:category, :name)
  end

end
