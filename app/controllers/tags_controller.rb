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
      redirect_to @tag
    else
      render "new"
    end
  end

  def edit

  end

  def update
    if @tag.update_attributes(permitted_params)
      redirect_to @tag
    else
      render "edit"
    end
  end

  def destroy
    @tag.destroy

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
