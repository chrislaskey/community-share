class DocumentTagsController < ApplicationController

  before_action :authenticate_user!
  before_action -> { reject_role :suspended }
  before_action :require_community

  def show
    @tag = Tag.in_community(current_community).find(params[:id])
    @documents = @tag.documents.paginate(page: params[:page]).order(:name)
  end

end
