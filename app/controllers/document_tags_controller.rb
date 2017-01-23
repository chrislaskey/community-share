class DocumentTagsController < ApplicationController

  def show
    @tag = Tag.find(params[:id])
  end

end
