class DocumentsController < ApplicationController

  before_action :find_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.all
    @tags = Tag.all
  end

  def show

  end

  def new
    @document = Document.new
    @tags = Tag.all
  end

  def create
    @document = Document.new(permitted_params)

    if @document.save
      redirect_to @document
    else
      render "new"
    end
  end

  def edit
    @tags = Tag.all
  end

  def update
    if @document.update_attributes(permitted_params)
      redirect_to @document
    else
      render "edit"
    end
  end

  def destroy
    @document.destroy

    redirect_to "index"
  end

  private

  def find_document
    @document ||= Document.find(params[:id])
  end

  def permitted_params
    params.require(:document).permit(:file, :name, tag_ids: [])
  end

end
