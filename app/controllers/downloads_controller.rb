class DownloadsController < ApplicationController

  before_action :authenticate_user!
  before_action -> { require_role :admin }

  def index
    @downloads = Download
      .includes(:document, :user)
      .in_community(current_community)
      .paginate(page: params[:page])
      .order(created_at: :desc)
  end

end
