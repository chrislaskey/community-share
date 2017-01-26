class TagsController < ApplicationController

  before_action :find_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags = Tag.all
  end

  def show
    @documents = @tag.documents
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new(permitted_params)

    if @tag.save
      flash[:success] = ["Successfully created #{@tag.name}"]
      redirect_to @tag
    else
      flash[:error] = @tag.errors.full_messages
      render "new"
    end
  end

  def edit

  end

  def update
    if @tag.update_attributes(permitted_params)
      flash[:success] = ["Successfully updated #{@tag.name}"]
      redirect_to @tag
    else
      flash[:error] = @tag.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @tag.destroy

    flash[:success] = ["Successfully deleted #{@tag.name}"]
    redirect_to "index"
  end

  private

  def find_tag
    @tag ||= Tag.find(params[:id])
  end

  def permitted_params
    params.require(:tag).permit(:category, :name)
  end

end
