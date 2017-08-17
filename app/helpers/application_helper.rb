module ApplicationHelper
  def heading(title, subtitle)
    raw "<h1>#{title} <small>#{subtitle}</small></h1>"
  end
end
