# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def breadcrumb
    controller.breadcrumbs.collect { |title, url| link_to h(title), polymorphic_path(url) } * '—'
  end
end
