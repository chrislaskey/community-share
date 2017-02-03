class DocumentsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_document, only: [:show, :download, :edit, :update, :destroy]
  before_action :find_tags, except: [:show, :destroy]

  def index
    @documents = Document.paginate(page: params[:page]).order(:name)
  end

  def show

  end

  def download
    return redirect_to @document.file.url
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(permitted_params)
    @document.user = current_user

    if @document.save
      flash[:success] = ["Successfully created #{@document.name}"]
      redirect_to @document
    else
      flash[:error] = @document.errors.full_messages
      render "new"
    end
  end

  def edit

  end

  def update
    if @document.update_attributes(permitted_params)
      flash[:success] = ["Successfully updated #{@document.name}"]
      redirect_to @document
    else
      flash[:error] = @document.errors.full_messages
      render "edit"
    end
  end

  def destroy
    @document.destroy

    flash[:success] = ["Successfully deleted #{@document.name}"]
    redirect_to "index"
  end

  private

  def find_document
    @document ||= Document.find(params[:id])
  end

  def find_tags
    @tags = Tag.all
  end

  def permitted_params
    params.require(:document).permit(:description, :file, :name, tag_ids: [])
  end

end
