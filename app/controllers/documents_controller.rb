class DocumentsController < ApplicationController

  before_action :authenticate_user!
  before_action -> { reject_role :suspended }
  before_action :require_community
  before_action :find_document, only: [:show, :download, :edit, :update, :destroy]
  before_action :find_tags, except: [:show, :destroy]

  def index
    @documents = Document
      .in_community(current_community)
      .paginate(page: params[:page])
      .order(:name)
  end

  def show
  end

  def download
    Download.create(document: @document, user: current_user, community: current_community)

    redirect_to @document.file.url
  end

  def new
    @document = Document.new
  end

  def create
    if read_only?
      flash[:notice] = "Current community is read only"
      return redirect_to documents_path
    end

    if current_community.over_limit? :file_count
      flash[:error] = "Over the maximum document count for the current subscription level"
      return redirect_to documents_path
    end

    if current_community.over_limit? :file_size
      flash[:error] = "Over the maximum document file size for the current subscription level"
      return redirect_to documents_path
    end

    @document = Document.new(permitted_params)
    @document.community = current_community
    @document.user = current_user

    if @document.save
      flash[:success] = "Successfully created #{@document.name}"
      redirect_to @document
    else
      flash[:error] = @document.errors.full_messages
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

    if role?(:contributor) && @document.created_by?(current_user)
      flash[:error] = "Contributors can only update records they have created"
      return redirect_to document_path(@document)
    end

    if @document.update_attributes(permitted_params)
      flash[:success] = "Successfully updated #{@document.name}"
      redirect_to @document
    else
      flash[:error] = @document.errors.full_messages
      render "edit"
    end
  end

  def destroy
    if read_only?
      return flash[:notice] = "Current community is read only"
    end

    if role?(:contributor) && @document.created_by?(current_user)
      flash[:error] = "Contributors can only delete records they have created"
      return redirect_to document_path(@document)
    end

    @document.destroy

    flash[:success] = "Successfully deleted #{@document.name}"
    redirect_to documents_path
  end

  private

  def find_document
    @document ||= Document.in_community(current_community).find(params[:id])
  end

  def find_tags
    @tags = Tag.in_community(current_community)
  end

  def permitted_params
    params.require(:document).permit(:description, :file, :name, tag_ids: [])
  end

end
