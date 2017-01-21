class DocumentsController < ApplicationController

  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(permitted_params)

    @document.save

    redirect_to @document
  end

  private

  def permitted_params
    params.require(:document).permit(:file, :name)
  end

end
