module ApplicationHelper
  def sortable(model, column, title=nil)
    title ||= t(column)
    path = model + '_path'
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, send(path, sort: column, direction: direction), {:class => css_class}
  end
end