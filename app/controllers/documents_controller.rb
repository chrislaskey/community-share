class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
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
      render 'new'
    end
  end

  private

  def permitted_params
    params.require(:document).permit(:file, :name, tag_ids: [])
  end

end
