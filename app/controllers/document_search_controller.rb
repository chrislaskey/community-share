class DocumentSearchController < ApplicationController
  before_action :authenticate_user!
  before_action -> { reject_role :suspended }
  before_action :require_community

  def index
  end
end
