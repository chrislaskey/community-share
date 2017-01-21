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
    attributes = permitted_params
    tags = attributes.delete(:tags)

    @document = Document.new(attributes)

    associate_tags(tags)

    if @document.save
      redirect_to @document
    else
      render 'new'
    end
  end

  private

  def permitted_params
    params.require(:document).permit(:file, :name, :tags)
  end

  def associate_tags(tags)
    @document.tags = tags.split(",").map(&:strip).map do |name|
      Tag.find_or_initialize_by(slug: name.parameterize).tap do |tag|
        tag.name ||= name
      end
    end
  end

end
