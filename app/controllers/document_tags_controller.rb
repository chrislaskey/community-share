class DocumentTagsController < ApplicationController

  before_action :authenticate_user!
  before_action -> { reject_role :suspended }

  def show
    @tag = Tag.in_community(current_community).find(params[:id])
    @documents = @tag.documents.paginate(page: params[:page])
  end

end
