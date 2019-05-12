module ApplicationHelper
  def sortable(model, column, title = nil)
    title ||= t(column)
    path = model + '_path'

    if column == (sort_column) || (column == ("customers.name") && sort_column == 'coalesce(c.name, customers.name)')
      css_class = "current #{sort_direction}"
    else
      css_class = nil
    end

    if (column == (sort_column) || ((column == ("customers.name") && sort_column == 'coalesce(c.name, customers.name)'))) && sort_direction == "asc"
      direction = "desc"
    else
      direction = "asc"
    end
    link_to title, send(path, sort: column, direction: direction), {:class => css_class}
  end
end