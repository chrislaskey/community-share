class DocumentTagsController < ApplicationController

  before_action :authenticate_user!

  def show
    @tag = Tag.find(params[:id])
  end

end
