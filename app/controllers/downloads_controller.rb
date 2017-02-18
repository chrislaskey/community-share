class DownloadsController < ApplicationController

  before_action :authenticate_user!
  before_action -> { require_role :admin }
  before_action :require_community

  def index
    @downloads = Download
      .includes(:document, :user)
      .in_community(current_community)
      .paginate(page: params[:page])
      .order(created_at: :desc)

    if current_community.demo?
      @downloads = @downloads.where(user: current_user)
    end
  end

end
